import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/views/discover/widgets/feed_topup.dart';
import 'package:nest/ui/views/discover/widgets/individual_post.dart';
import 'package:stacked/stacked.dart';

import 'discover_viewmodel.dart';

class DiscoverView extends StackedView<DiscoverViewModel> {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DiscoverViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body:  Stack(
          children: [
            // Video Feed
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.posts.length,
              onPageChanged: viewModel.onPageChanged,
              itemBuilder: (context, index) {
                return FeedPostWidget(
                  post: viewModel.posts[index],
                  onLike: () => viewModel.toggleLike(viewModel.posts[index].id),
                  onFollow: () => viewModel.toggleFollow(viewModel.posts[index].id),
                  onComment: () => viewModel.openComments(viewModel.posts[index].id),
                  onShare: () => viewModel.sharePost(viewModel.posts[index].id),
                );
              },
            ),

            // Top Navigation Bar
            const FeedTopBarWidget(),
          ],
        ),
      ),
    );
  }

  @override
  DiscoverViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DiscoverViewModel();
}
