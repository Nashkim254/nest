import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:nest/models/api_response.dart';
import 'package:nest/models/login_model.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/app_urls.dart';
import 'package:stacked/stacked.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/api_exceptions.dart';
import '../models/registration_model.dart';
import '../models/password_reset_model.dart';

class AuthService with ListenableServiceMixin {
  final IApiService _apiService = locator<IApiService>();
  final prefsService = locator<SharedPreferencesService>();
  _getAuthToken() {
    return prefsService.getAuthToken();
  }

  Future<void> _setAuthToken(String token) async {
    await prefsService.setAuthToken(token);
  }

  String? get token => _getAuthToken() ?? '';
  Future register(RegistrationModel model) async {
    try {
      final response = await _apiService.post(
        AppUrls.register,
        data: model.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future requestChangePassword(PasswordResetRequestModel model) async {
    try {
      final response = await _apiService.post(AppUrls.reQuestPasswordReset,
          data: model.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(
            response.message ?? 'Failed to request password reset');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future resetPassword(PasswordResetModel model) async {
    try {
      final response =
          await _apiService.post(AppUrls.resetPassword, data: model.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to reset password');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> sign(LoginModel model) async {
    try {
      final response = await _apiService.post(
        AppUrls.login,
        data: model.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: AppUrls.oAuthUrl.toString(),
        callbackUrlScheme: 'com.nesthaps.nest',
      );

      if (result.isEmpty) {
        throw ApiException('OAuth authentication was cancelled');
      }

      // Extract code from resulting url
      final uri = Uri.parse(result);
      final code = uri.queryParameters['code'];
      final scope = uri.queryParameters['scope'];
      final auth = uri.queryParameters['authuser'];
      final prompt = uri.queryParameters['prompt'];

      if (code == null) {
        throw ApiException('No authorization code received from Google');
      }

      Map<String, dynamic> params = {
        'code': code,
        'client_id': AppUrls.NEXT_PUBLIC_GOOGLE_ACCESS_ID,
        'redirect_uri': AppUrls.NEXT_PUBLIC_GOOGLE_REDIRECT,
      };
      return params;
    } catch (e) {
      debugPrint('Google sign-in error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> appleSignIn() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: AppUrls.appleUrl.toString(),
        callbackUrlScheme: 'com.nesthaps.nest',
      );

      if (result.isEmpty) {
        throw ApiException('Apple authentication was cancelled');
      }

      // Extract parameters from resulting url
      final uri = Uri.parse(result);
      final code = uri.queryParameters['code'];
      final state = uri.queryParameters['state'];
      final id_token = uri.queryParameters['id_token'];

      if (code == null) {
        throw ApiException('No authorization code received from Apple');
      }

      Map<String, dynamic> params = {
        'code': code,
        'client_id': AppUrls.NEXT_PUBLIC_APPLE_ACCESS_ID,
        'redirect_uri': AppUrls.NEXT_PUBLIC_APPLE_REDIRECT,
      };
      return params;
    } catch (e) {
      debugPrint('Apple sign-in error: $e');
      rethrow;
    }
  }

  Future<ApiResponse> oAuthGoogle(
      {required Map<String, dynamic> queryParams}) async {
    try {
      final response = await _apiService.post(
        '${AppUrls.baseAuthUrl}/${AppUrls.googleUrl}',
        data: json.encode(queryParams),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      debugPrint('Error during Google OAuth: $e');
      rethrow;
    }
  }

  Future<ApiResponse> oAuthApple(
      {required Map<String, dynamic> queryParams}) async {
    try {
      final response = await _apiService.post(
        '${AppUrls.baseAuthUrl}/${AppUrls.appleApiUrl}',
        data: json.encode(queryParams),
        parser: (data) => ApiResponse.fromJson(data, (data) => data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data!;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      debugPrint('Error during Google OAuth: $e');
      rethrow;
    }
  }
}
