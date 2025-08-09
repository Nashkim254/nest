import 'package:flutter/material.dart';
import 'package:nest/ui/views/for_you/widgets/individual_post.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import 'for_you_viewmodel.dart';

class ForYouView extends StackedView<ForYouViewModel> {
  const ForYouView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForYouViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: Stack(
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
  ForYouViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForYouViewModel();
}
