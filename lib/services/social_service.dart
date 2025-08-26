import 'package:nest/models/create_post.dart';
import 'package:nest/services/shared_preferences_service.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/api_exceptions.dart';
import '../ui/common/app_urls.dart';

class SocialService {
  final IApiService _apiService = locator<IApiService>();
  final prefsService = locator<SharedPreferencesService>();

  Future createPost({required CreatePostRequest post}) async {
    try {
      final response =
          await _apiService.post(AppUrls.createPosts, data: post.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future claudFlareSignVideo({int maxDurationSeconds = 30}) async {
    try {
      final response = await _apiService.get(
        AppUrls.cloudflareSignVideo,
        queryParameters: {'max': maxDurationSeconds.toString()},
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

  Future getPosts({required int page, required int size}) async {
    try {
      final response =
          await _apiService.get(AppUrls.createPosts, queryParameters: {
        'page': page,
        'limit': size,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getUserPosts(
      {required int page, required int size, required int id}) async {
    try {
      final response = await _apiService
          .get('${AppUrls.getUserPostsUrl}/$id', queryParameters: {
        'page': page,
        'limit': size,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }
}
