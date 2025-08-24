import 'package:flutter/foundation.dart';
import 'package:nest/services/comments_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/post_models.dart';

class EventActivityViewModel extends BaseViewModel {
  final bottomSheet = locator<BottomSheetService>();
  final comments = locator<CommentsService>();

  toggleLike(Post post) async {
    try {
      final response = await comments.toggleLikePost(post.id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        post.copyWith(
          isLiked: !post.isLiked,
          likeCount: post.isLiked ? post.likeCount - 1 : post.likeCount + 1,
        );
        notifyListeners();
      } else {
        throw Exception('Failed to toggle like on post');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _loadComments(int id) async {
    setBusy(true);
    try {
      final response = await comments.getComments(id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          debugPrint("Loaded ${response.data}", wrapWidth: 1024);
        }

        final List<dynamic> data = response.data ?? [];
      } else {
        throw Exception('Failed to load comments');
      }
      rebuildUi();
    } catch (error) {
      // Handle error - could show snackbar or error state
      setError(error);
    } finally {
      setBusy(false);
    }
  }

  Future openComments(int id) async {
    final result = await bottomSheet.showCustomSheet(
      variant: BottomSheetType.comments,
      title: 'Comments',
      data: id.toString(), // or whatever data you need to pass
      isScrollControlled: true,
    );
    if (result != null && result.confirmed) {}
    notifyListeners();
  }

  sharePost(int id) {}
  editPost(int id) {}
}
