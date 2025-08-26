import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/views/event_activity/widgets/event_activity_card.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'event_activity_viewmodel.dart';

class EventActivityView extends StackedView<EventActivityViewModel> {
  const EventActivityView({
    Key? key,
  }) : super(key: key);

  @override
  onViewModelReady(EventActivityViewModel viewModel) {
    viewModel.getUserPosts();
    return super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    EventActivityViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: kcWhiteColor,
        ),
        backgroundColor: kcDarkColor,
        title: Text("Event Activity",
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            )),
        centerTitle: true,
        elevation: 0,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.more_vert,
          //     color: kcWhiteColor,
          //   ),
          // ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await viewModel.refreshPosts();
        },
        color: kcWhiteColor,
        backgroundColor: kcDarkColor,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // Trigger load more when user reaches 80% of the scroll
            if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent * 0.8 &&
                !viewModel.isBusy &&
                !viewModel.isLoadingMore &&
                viewModel.hasMoreData) {
              viewModel.loadMorePosts();
            }
            return false;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.posts.length +
                      (viewModel.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Show loading indicator at the bottom when loading more
                    if (index == viewModel.posts.length) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kcWhiteColor),
                        ),
                      );
                    }

                    final post = viewModel.posts[index];
                    return EventActivityCard(
                      post: post,
                      index: index,
                      onLike: (post) => viewModel.toggleLike(post),
                      onComment: (post) {
                        print('Tapped');
                        viewModel.openComments(post.id);
                      },
                      onShare: (post) => viewModel.sharePost(post),
                      onEdit: (post) => viewModel.editPost(post.id),
                    );
                  },
                ),
                // Show message when no more data available
                if (!viewModel.hasMoreData && viewModel.posts.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'No more posts to load',
                      style: TextStyle(
                        color: kcWhiteColor.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  EventActivityViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EventActivityViewModel();
}
