class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message';
}

class NetworkException extends ApiException {
  NetworkException(String message) : super(message);
}

class ServerException extends ApiException {
  ServerException(String message, {int? statusCode, dynamic data})
      : super(message, statusCode: statusCode, data: data);
}

class ValidationException extends ApiException {
  final Map<String, dynamic>? errors;

  ValidationException(String message, {this.errors})
      : super(message, data: errors);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super('Unauthorized access', statusCode: 401);
}
