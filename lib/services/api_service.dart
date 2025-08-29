import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/app_urls.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/api_exceptions.dart';
import '../models/api_response.dart';

class ApiService implements IApiService {
  late final Dio _dio;
  final Logger _logger = Logger();
  final String baseUrl = AppUrls.baseUrl;
  final prefsService = locator<SharedPreferencesService>();
  ApiService({
    int connectTimeout = 800000,
    int receiveTimeout = 800000,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Request Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          _logger.d('Headers: ${options.headers}');
          if (options.data != null) {
            _logger.d('Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d(
              'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          _logger.d('Data: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          _logger.e(
              'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
          _logger.e('Message: ${error.message}');
          if (error.response?.data != null) {
            _logger.e('Error Data: ${error.response?.data}');
          }
          handler.next(error);
        },
      ),
    );

    // Auth Token Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          final token = await _getAuthToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

    // Retry Interceptor with proper limits
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          // Check if this request has already been retried
          final retryCount = error.requestOptions.extra['retry_count'] ?? 0;
          const maxRetries = 2; // Maximum number of retries

          if (retryCount < maxRetries && _shouldRetry(error)) {
            try {
              _logger.d(
                  'Retrying request (attempt ${retryCount + 1}/$maxRetries)');

              // Mark this as a retry
              error.requestOptions.extra['retry_count'] = retryCount + 1;

              // Add delay between retries
              await Future.delayed(
                  Duration(milliseconds: (1000 * (retryCount + 1)).toInt()));

              final response = await _dio.fetch(error.requestOptions);
              handler.resolve(response);
              return;
            } catch (e) {
              _logger.e('Retry failed: $e');
              // If retry fails, continue with original error
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<String?> _getAuthToken() async {
    return prefsService.getAuthToken();
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError;
  }

  @override
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? parser,
  }) async {
    return _performRequest<T>(
      () => _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? parser,
  }) async {
    return _performRequest<T>(
      () => _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? parser,
  }) async {
    return _performRequest<T>(
      () => _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? parser,
  }) async {
    return _performRequest<T>(
      () => _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  Future<ApiResponse<T>> _performRequest<T>(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  ApiResponse<T> _handleResponse<T>(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      // Return response data as-is, no parsing
      return ApiResponse.success(
        response.data as T,
        message: 'Request successful',
        statusCode: response.statusCode,
      );
    } else {
      throw ServerException(
        'Server returned error: ${response.statusCode}',
        statusCode: response.statusCode,
        data: response.data,
      );
    }
  }

  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
            'Connection timeout. Please check your internet connection.');

      case DioExceptionType.connectionError:
        return NetworkException(
            'Connection error. Please check your internet connection.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return ApiException('Request was cancelled');

      default:
        return ApiException('Network error: ${error.message}');
    }
  }

  ApiException _handleBadResponse(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    switch (statusCode) {
      case 400:
        if (data is Map<String, dynamic> && data.containsKey('errors')) {
          return ValidationException(
            data['message'] ?? 'Validation failed',
            errors: data['errors'],
          );
        }
        return ApiException(
          data?['message'] ?? 'Bad request',
          statusCode: statusCode,
          data: data,
        );

      case 401:
        return UnauthorizedException();

      case 403:
        return ApiException(
          'Access forbidden',
          statusCode: statusCode,
          data: data,
        );

      case 404:
        return ApiException(
          'Resource not found',
          statusCode: statusCode,
          data: data,
        );

      case 422:
        return ValidationException(
          data?['message'] ?? 'Validation failed',
          errors: data?['errors'],
        );

      case 500:
        return ServerException(
          'Internal server error',
          statusCode: statusCode,
          data: data,
        );

      default:
        return ServerException(
          data?['message'] ?? 'Server error occurred',
          statusCode: statusCode,
          data: data,
        );
    }
  }
}
