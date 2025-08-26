import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
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
          CommentsHeaderWidget(
            commentsCount: viewModel.comments.length,
            onClose: viewModel.closeBottomSheet,
          ),

          // Comments List with Pull-to-Refresh
          Expanded(
            child: viewModel.isLoading && viewModel.comments.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kcPrimaryColor,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: viewModel.refreshComments,
                    color: kcPrimaryColor,
                    backgroundColor: kcDarkColor,
                    child: CommentsListWidget(
                      comments: viewModel.comments,
                      scrollController: viewModel.scrollController,
                      onLikeComment: viewModel.toggleLikeComment,
                      isLoadingMore: viewModel.isLoadingMore,
                      hasMoreComments: viewModel.hasMoreComments,
                    ),
                  ),
          ),

          // Comment Input
          CommentsInputWidget(
            controller: viewModel.commentController,
            canSend: viewModel.canSendComment,
            isSending: viewModel.isSendingComment,
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
  final int commentsCount;
  final VoidCallback onClose;

  const CommentsHeaderWidget({
    Key? key,
    required this.commentsCount,
    required this.onClose,
  }) : super(key: key);

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
          Text(
            commentsCount == 0 ? 'Comments' : 'Comments ($commentsCount)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: onClose,
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
  final bool isLoadingMore;
  final bool hasMoreComments;

  const CommentsListWidget({
    Key? key,
    required this.comments,
    required this.scrollController,
    required this.onLikeComment,
    required this.isLoadingMore,
    required this.hasMoreComments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          const Center(
            child: Column(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 48,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No comments yet.\nBe the first to comment!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount:
          comments.length + (isLoadingMore ? 1 : 0) + (hasMoreComments ? 0 : 1),
      itemBuilder: (context, index) {
        // Loading indicator at the bottom
        if (index == comments.length && isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(
                color: kcPrimaryColor,
                strokeWidth: 2,
              ),
            ),
          );
        }

        // End of comments indicator
        if (index == comments.length && !hasMoreComments && !isLoadingMore) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              comments.length == 1
                  ? 'End of comments'
                  : 'You\'ve seen all comments',
              style: TextStyle(
                color: Colors.grey.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          );
        }

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
          // User Avatar with fallback
          CircleAvatar(
            radius: 20,
            backgroundImage: comment.userAvatar.isNotEmpty
                ? NetworkImage(comment.userAvatar)
                : null,
            child: comment.userAvatar.isEmpty
                ? Text(
                    comment.username.isNotEmpty
                        ? comment.username[0].toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),

          // Comment Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and Time
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      comment.timeAgo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Comment Text
                Text(
                  comment.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                if (comment.likeCount > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    comment.likeCount == 1
                        ? '1 like'
                        : '${comment.likeCount} likes',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Like Button with animation
          GestureDetector(
            onTap: onLike,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  comment.isLiked ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(comment.isLiked),
                  color: comment.isLiked ? kcPrimaryColor : Colors.grey,
                  size: 18,
                ),
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
  final bool isSending;
  final VoidCallback onChanged;
  final VoidCallback onSend;

  const CommentsInputWidget({
    Key? key,
    required this.controller,
    required this.canSend,
    required this.isSending,
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
                enabled: !isSending,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: AppInputDecoration.standard(
                  hintText: isSending ? 'Sending...' : 'Add a comment..',
                ),
                maxLines: null,
                maxLength: 500, // Reasonable character limit
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(width: 12),

            // Send Button
            GestureDetector(
              onTap: (canSend && !isSending) ? onSend : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: (canSend && !isSending) ? kcPrimaryColor : kcGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isSending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Send',
                        style: TextStyle(
                          color: (canSend && !isSending)
                              ? kcWhiteColor
                              : kcOffGreyColor,
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
