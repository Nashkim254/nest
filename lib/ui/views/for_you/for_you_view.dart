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
        body: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(
                  color: kcPrimaryColor,
                ),
              )
            : viewModel.posts.isEmpty
                ? const Center(
                    child: Text(
                      'No posts available',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Stack(
                    children: [
                      // Video Feed
                      RefreshIndicator(
                        onRefresh: viewModel.refreshPosts,
                        child: PageView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: viewModel.posts.length,
                          onPageChanged: viewModel.onPageChanged,
                          itemBuilder: (context, index) {
                            return FeedPostWidget(
                              post: viewModel.posts[index],
                              onLike: () =>
                                  viewModel.toggleLike(viewModel.posts[index]),
                              onFollow: () => viewModel.toggleFollow(
                                  viewModel.posts[index].id.toString()),
                              onComment: () => viewModel
                                  .openComments(viewModel.posts[index].id),
                              onShare: () =>
                                  viewModel.sharePost(viewModel.posts[index]),
                              isVisible: index == viewModel.currentIndex,
                              onRepost: () => viewModel
                                  .repost(viewModel.posts[index].id.toString()),
                              onProfileTap: (userId) => viewModel.navigateToProfile(userId),
                            );
                          },
                        ),
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

  @override
  void onViewModelReady(ForYouViewModel viewModel) {
    viewModel.initialize();
  }
}
