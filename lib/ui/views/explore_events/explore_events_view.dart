import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/utils/utilities.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'explore_events_viewmodel.dart';

class ExploreEventsView extends StackedView<ExploreEventsViewModel> {
  const ExploreEventsView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(ExploreEventsViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    ExploreEventsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              viewModel.navigationService.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kcWhiteColor,
            ),
          ),
          backgroundColor: kcDarkColor,
          title: Text(
            "My Nest",
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                // Handle search action
              },
              child: SvgPicture.asset(notification),
            ),
            horizontalSpaceSmall,
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(avatar),
            ),
          ],
        ),
        backgroundColor: kcDarkColor,
        body: RefreshIndicator(
          onRefresh: () => viewModel.onRefresh(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              // Improved scroll detection for load more
              if (!viewModel.isBusy &&
                  !viewModel.isLoadingMore &&
                  viewModel.hasMoreData &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                viewModel.onLoadMore();
              }
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalSpaceMedium,
                  TextFormField(
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kcWhiteColor,
                    ),
                    controller: viewModel.searchController,
                    focusNode: viewModel.searchFocusNode,
                    decoration: AppInputDecoration.search(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: kcGreyColor,
                      ),
                    ),
                    onChanged: viewModel.onSearchChanged,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Explore Events',
                    style: titleTextMedium,
                  ),
                  verticalSpaceSmall,
                  Expanded(
                    child: viewModel.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: kcPrimaryColor,
                          ))
                        : viewModel.upcomingEvents.isEmpty
                            ? const Center(
                                child: Text(
                                  "No events found",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 16),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: viewModel.upcomingEvents.length +
                                    (viewModel.hasMoreData ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index ==
                                      viewModel.upcomingEvents.length) {
                                    // Bottom loader (for pagination / load more)
                                    return viewModel.isLoadingMore
                                        ? const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: kcPrimaryColor,
                                            )),
                                          )
                                        : const SizedBox.shrink();
                                  }

                                  final event = viewModel.upcomingEvents[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () =>
                                          viewModel.navigateToViewEvent(event),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kcDarkGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              color: kcContainerBorderColor),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                child: Image.network(
                                                  event.flyerUrl,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                event.title,
                                                style: titleTextMedium.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(calendar,
                                                      color: kcSubtitleColor),
                                                  horizontalSpaceSmall,
                                                  Text(
                                                    formatter.format(
                                                        event.startTime),
                                                    style: titleTextMedium
                                                        .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kcSubtitleColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(pin,
                                                      color: kcSubtitleColor),
                                                  horizontalSpaceSmall,
                                                  Text(
                                                    event.location,
                                                    style: titleTextMedium
                                                        .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kcSubtitleColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                  verticalSpaceMedium,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kcContainerColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ready to host your own unforgettable\nnight?',
                          style: titleTextMedium.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpaceMedium,
                        SizedBox(
                          width: 175,
                          child: AppButton(
                            labelText: 'Create New Event',
                            onTap: () => viewModel.navigateToCreateEvent(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ExploreEventsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExploreEventsViewModel();
}
