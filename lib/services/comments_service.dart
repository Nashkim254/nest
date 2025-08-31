import 'package:logger/logger.dart';
import 'package:nest/abstractClasses/abstract_class.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/models/api_response.dart';
import 'package:nest/ui/common/app_urls.dart';

class CommentsService {
  final apiService = locator<IApiService>();
  getComments(int postId) async {
    try {
      final response =
          await apiService.get('${AppUrls.social}/posts/$postId/comments');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      rethrow;
    }
  }

  getMoreComments(int postId, {required int offset}) {}

  Future postComment(int postId, String commentText) async {
    Logger().i(postId);
    try {
      final response = await apiService.post(
          '${AppUrls.social}/posts/$postId/comments',
          data: {'content': commentText});
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> toggleLikeComment(int commentId) async {
    try {
      final response = await apiService.post(
        '${AppUrls.social}/comments/$commentId/like',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to toggle like on comment');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> toggleLikePost(int postId) async {
    try {
      final response = await apiService.post(
        '${AppUrls.social}/posts/$postId/like',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to toggle like on comment');
      }
    } catch (e) {
      rethrow;
    }
  }
}
