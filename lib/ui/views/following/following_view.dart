import 'package:flutter/material.dart';
import 'package:nest/ui/views/following/widgets/individual_post.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import 'following_viewmodel.dart';

class FollowingView extends StackedView<FollowingViewModel> {
  const FollowingView({Key? key}) : super(key: key);
  @override
  Widget builder(
    BuildContext context,
    FollowingViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.posts.length,
              onPageChanged: viewModel.onPageChanged,
              itemBuilder: (context, index) {
                return FeedPostWidget(
                  post: viewModel.posts[index],
                  onLike: () => viewModel.toggleLike(viewModel.posts[index].id),
                  onFollow: () =>
                      viewModel.toggleFollow(viewModel.posts[index].id),
                  onComment: () =>
                      viewModel.openComments(viewModel.posts[index].id),
                  onShare: () => viewModel.sharePost(viewModel.posts[index].id),
                  isVisible: true,
                  onRepost: () => viewModel.repost(viewModel.posts[index].id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  FollowingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FollowingViewModel();
}
