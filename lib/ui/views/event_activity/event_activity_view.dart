import 'package:flutter/material.dart';
import 'package:nest/models/event_activity.dart';
import 'package:nest/models/post_models.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/views/event_activity/widgets/event_activity_card.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'event_activity_viewmodel.dart';

class EventActivityView extends StackedView<EventActivityViewModel> {
  const EventActivityView({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;
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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: kcWhiteColor,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return EventActivityCard(post: post, index: index);
                },
              ),
            ],
          ),
        ));
  }

  @override
  EventActivityViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EventActivityViewModel();
}
