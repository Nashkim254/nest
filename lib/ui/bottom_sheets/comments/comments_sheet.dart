import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/comment.dart';
import '../../common/app_inputdecoration.dart';
import 'comments_sheet_model.dart';

class CommentsSheet extends StackedView<CommentsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CommentsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CommentsSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: kcDarkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          const CommentsHeaderWidget(),

          // Comments List
          Expanded(
            child: viewModel.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kcPrimaryColor,
                    ),
                  )
                : CommentsListWidget(
                    comments: viewModel.comments,
                    scrollController: viewModel.scrollController,
                    onLikeComment: viewModel.toggleLikeComment,
                  ),
          ),

          // Comment Input
          CommentsInputWidget(
            controller: viewModel.commentController,
            canSend: viewModel.canSendComment,
            onChanged: viewModel.onCommentTextChanged,
            onSend: viewModel.sendComment,
          ),
        ],
      ),
    );
  }

  @override
  void onViewModelReady(CommentsSheetModel viewModel) {
    viewModel.initialize(int.parse(request.data.toString()));
    super.onViewModelReady(viewModel);
  }

  @override
  CommentsSheetModel viewModelBuilder(BuildContext context) =>
      CommentsSheetModel();
}

class CommentsHeaderWidget extends StatelessWidget {
  const CommentsHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Comments',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

// Comments List Widget
class CommentsListWidget extends StatelessWidget {
  final List<Comment> comments;
  final ScrollController scrollController;
  final Function(int) onLikeComment;

  const CommentsListWidget({
    Key? key,
    required this.comments,
    required this.scrollController,
    required this.onLikeComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const Center(
        child: Text(
          'No comments yet.\nBe the first to comment!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentItemWidget(
          comment: comments[index],
          onLike: () => onLikeComment(comments[index].id),
        );
      },
    );
  }
}

// Individual Comment Item Widget
class CommentItemWidget extends StatelessWidget {
  final Comment comment;
  final VoidCallback onLike;

  const CommentItemWidget({
    Key? key,
    required this.comment,
    required this.onLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(comment.userAvatar),
          ),
          const SizedBox(width: 12),

          // Comment Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username
                Text(
                  comment.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),

                // Comment Text
                Text(
                  comment.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),

                // Time
                Text(
                  comment.timeAgo,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Like Button
          GestureDetector(
            onTap: onLike,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                comment.isLiked ? Icons.favorite : Icons.favorite_border,
                color: comment.isLiked ? Colors.orange : Colors.grey,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Comments Input Widget
class CommentsInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool canSend;
  final VoidCallback onChanged;
  final VoidCallback onSend;

  const CommentsInputWidget({
    Key? key,
    required this.controller,
    required this.canSend,
    required this.onChanged,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Text Input
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (_) => onChanged(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration:
                    AppInputDecoration.standard(hintText: 'Add a comment..'),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(width: 12),

            // Send Button
            GestureDetector(
              onTap: canSend ? onSend : null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: canSend ? kcPrimaryColor : kcGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: canSend ? kcWhiteColor : kcOffGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
