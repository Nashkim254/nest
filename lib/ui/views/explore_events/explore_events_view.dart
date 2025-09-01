// Updated ExploreEventsView with password protection
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
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () => viewModel.onRefresh(),
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
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

                                      final event =
                                          viewModel.upcomingEvents[index];
                                      final isPasswordProtected =
                                          event.isPasswordProtected ?? false;

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Opacity(
                                          // Disable password-protected events visually
                                          opacity:
                                              isPasswordProtected ? 0.6 : 1.0,
                                          child: InkWell(
                                            onTap: () {
                                              if (isPasswordProtected) {
                                                // Show password dialog
                                                viewModel.showPasswordDialog(
                                                    context, event);
                                              } else {
                                                viewModel
                                                    .navigateToViewEvent(event);
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kcDarkGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                    color: isPasswordProtected
                                                        ? Colors.orange
                                                            .withOpacity(0.5)
                                                        : kcContainerBorderColor),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 200,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    16),
                                                            topRight:
                                                                Radius.circular(
                                                                    16),
                                                          ),
                                                          child: Image.network(
                                                            event.flyerUrl,
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          event.title,
                                                          style: titleTextMedium
                                                              .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                calendar,
                                                                color:
                                                                    kcSubtitleColor),
                                                            horizontalSpaceSmall,
                                                            Text(
                                                              formatter.format(
                                                                  event
                                                                      .startTime),
                                                              style:
                                                                  titleTextMedium
                                                                      .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    kcSubtitleColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                pin,
                                                                color:
                                                                    kcSubtitleColor),
                                                            horizontalSpaceSmall,
                                                            Text(
                                                              event.location,
                                                              style:
                                                                  titleTextMedium
                                                                      .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    kcSubtitleColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Password protected indicator
                                                  if (isPasswordProtected)
                                                    Positioned(
                                                      top: 8,
                                                      right: 8,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black54,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: const Icon(
                                                          Icons.lock,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
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
            // Password dialog overlay
            if (viewModel.showPasswordDialogState)
              _buildPasswordDialog(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordDialog(
      BuildContext context, ExploreEventsViewModel viewModel) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kcDarkGreyColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kcContainerBorderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.lock,
                    color: Colors.orange,
                    size: 24,
                  ),
                  horizontalSpaceSmall,
                  Text(
                    'Password Required',
                    style: titleTextMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => viewModel.closePasswordDialog(),
                    icon: const Icon(
                      Icons.close,
                      color: kcGreyColor,
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              Text(
                'This event is password protected. Please enter the password to view details.',
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcSubtitleColor,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,
              TextFormField(
                controller: viewModel.passwordController,
                obscureText: !viewModel.showPassword,
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kcWhiteColor,
                ),
                decoration: AppInputDecoration.standard(
                  hintText: 'Enter password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kcGreyColor,
                    ),
                    onPressed: () => viewModel.togglePasswordVisibility(),
                  ),
                ),
              ),
              if (viewModel.passwordError.isNotEmpty) ...[
                verticalSpaceSmall,
                Text(
                  viewModel.passwordError,
                  style: titleTextMedium.copyWith(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ],
              verticalSpaceMedium,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => viewModel.closePasswordDialog(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kcGreyColor),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Cancel',
                        style: titleTextMedium.copyWith(
                          fontSize: 14,
                          color: kcGreyColor,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: AppButton(
                      labelText: viewModel.isValidatingPassword
                          ? 'Validating...'
                          : 'Enter',
                      onTap: () => viewModel.validatePassword(),
                    ),
                  ),
                ],
              ),
            ],
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
