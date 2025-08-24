import 'package:nest/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/api_exceptions.dart';
import '../models/organization_model.dart';
import '../models/update_profile_input.dart';
import '../ui/common/app_urls.dart';

class UserService with ListenableServiceMixin {
  final IApiService _apiService = locator<IApiService>();
  final prefsService = locator<SharedPreferencesService>();

  Future getUserProfile() async {
    try {
      final response = await _apiService.get(
        AppUrls.userProfile,
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

  Future getRecommendedUsers() async {
    try {
      final response = await _apiService.get(
        AppUrls.recommendedUsers,
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

  Future searchUsers(
      {required String query, required int page, required int limit}) async {
    try {
      final response = await _apiService.get(
        AppUrls.searchUsers,
        queryParameters: {
          'q': query,
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getMyTickets() async {
    try {
      final response = await _apiService.get(
        AppUrls.myTickets,
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

  Future editUserProfile(
      {required UpdateProfileInput profileUpdateInput}) async {
    try {
      final response = await _apiService.put(AppUrls.userProfile,
          data: profileUpdateInput.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getMyOrganization() async {
    try {
      final response = await _apiService.get(AppUrls.myOrganization);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getMyOrganizationAnalytics(int? id) async {
    try {
      final response =
          await _apiService.get('${AppUrls.organizations}/$id/analytics');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future createOrganization({required Organization organization}) async {
    try {
      final response = await _apiService.post(
        AppUrls.organizations,
        data: organization.toJson(),
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

  Future followUnfollowUser({required int id, required bool isFollow}) async {
    try {
      final response = isFollow
          ? await _apiService.post('${AppUrls.followUser}/$id/follow')
          : await _apiService.delete('${AppUrls.followUser}/$id/follow');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ??
            'Failed to ${isFollow ? "follow" : "unfollow"} user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> openSocialLink(String url) async {
    final Uri uri = Uri.parse(url);

    await launchUrl(
      uri,
    );
  }
}
