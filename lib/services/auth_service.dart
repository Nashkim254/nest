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

  Future requestChangePassword(Map<String, dynamic> body) async {
    try {
      final response =
          await _apiService.post(AppUrls.reQuestPasswordReset, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future resetPassword(Map<String, dynamic> body) async {
    try {
      final response =
          await _apiService.post(AppUrls.resetPassword, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
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
    var result;
    try {
      result = await FlutterWebAuth2.authenticate(
        url: AppUrls.oAuthUrl.toString(),
        callbackUrlScheme:
            Platform.isAndroid ? 'app.thedoor.studio' : "app.thedoor.studio",
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    // Extract code from resulting url
    final code = Uri.parse(result).queryParameters['code'];
    final scope = Uri.parse(result).queryParameters['scope'];
    final auth = Uri.parse(result).queryParameters['authuser'];
    final prompt = Uri.parse(result).queryParameters['prompt'];
    Map<String, dynamic> params = {
      'code': code,
      'scope': scope,
      'authuser': auth,
      'prompt': prompt,
      'client_id': AppUrls.NEXT_PUBLIC_GOOGLE_ACCESS_ID,
      'redirect_uri': 'app.thedoor.studio://',
    };
    return params;
  }

  Future<Map<String, dynamic>> appleSignIn() async {
    var result;
    try {
      result = await FlutterWebAuth2.authenticate(
        url: AppUrls.appleUrl.toString(),
        callbackUrlScheme:
            Platform.isAndroid ? 'app.thedoor.studio' : "app.thedoor.studio",
      );
    } catch (e) {
      print(e.toString());
    }
    final code = Uri.parse(result).queryParameters['code'];
    final state = Uri.parse(result).queryParameters['state'];
    final id_token = Uri.parse(result).queryParameters['id_token'];
    Map<String, dynamic> params = {
      'code': code,
      'state': '',
      'id_token': '',
      'redirect_uri': AppUrls.NEXT_PUBLIC_APPLE_REDIRECT,
    };
    return params;
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
