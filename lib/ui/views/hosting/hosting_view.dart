import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/hosting/widgets/analytics.dart';
import 'package:nest/ui/views/hosting/widgets/event_card.dart';
import 'package:nest/ui/views/hosting/widgets/events.dart';
import 'package:stacked/stacked.dart';

import '../../../models/event_data.dart';
import '../../common/app_strings.dart';
import 'hosting_viewmodel.dart';

class HostingView extends StackedView<HostingViewModel> {
  const HostingView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(HostingViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HostingViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await viewModel.onRefresh();
        },
        child: Scaffold(
          backgroundColor: kcDarkColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kcDarkColor,
            title: Text(
              "Host Dashboard",
              style: titleTextMedium.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  // Handle search action
                },
                child: SvgPicture.asset(settings),
              ),
            ],
            elevation: 0,
          ),
          body: !viewModel.hasOrganizations
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppButton(
                      buttonColor: kcTertiaryWithOpacityColor,
                      labelText: 'Create Organization',
                      onTap: () => viewModel.navigateToCreateOrganization(),
                      leadingIcon: add,
                    ),
                  ),
                )
              : viewModel.organizationAnalytics == null
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: kcPrimaryColor,
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spacedDivider,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quick Stats',
                                  style: titleTextMedium.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: kcWhiteColor,
                                  ),
                                ),
                                verticalSpaceSmall,
                                Wrap(
                                  spacing: 32,
                                  runSpacing: 16.0,
                                  children: [
                                    _buildQuickStatsContainer(
                                      title: 'Total Events',
                                      value: viewModel.organizationAnalytics!
                                          .eventAnalytics.totalEvents
                                          .toString(),
                                    ),
                                    _buildQuickStatsContainer(
                                      title: 'Tickets Sold',
                                      value: viewModel.organizationAnalytics!
                                          .ticketAnalytics.validatedTickets
                                          .toString(),
                                    ),
                                    _buildQuickStatsContainer(
                                      title: 'Views',
                                      value: viewModel.organizationAnalytics!
                                          .eventAnalytics.activeEvents
                                          .toString(),
                                    ),
                                  ],
                                ),
                                verticalSpaceMedium,
                                AppButton(
                                  labelText: 'Create New Event',
                                  onTap: () =>
                                      viewModel.navigateToCreateEvent(),
                                  leadingIcon: addOutlined,
                                ),
                                verticalSpaceSmall,
                                AppButton(
                                  buttonColor: kcSecondaryWithOpacityColor,
                                  labelText: 'View Analytics',
                                  onTap: () {},
                                  leadingIcon: analytics,
                                ),
                                verticalSpaceMedium,
                                Text(
                                  'Upcoming Events',
                                  style: titleTextMedium.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: kcWhiteColor,
                                  ),
                                ),
                                verticalSpaceSmall,
                                ListView.builder(
                                  itemBuilder: (context, index) {
                                    return EventCardWidget(
                                      data: viewModel.upcomingEvents[index],
                                      onTap: () =>
                                          viewModel.navigateToEventDetails(
                                        viewModel.upcomingEvents[index],
                                      ),
                                    );
                                  },
                                  itemCount: viewModel.upcomingEvents.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                                verticalSpaceMedium,
                                Text(
                                  'Upcoming Events',
                                  style: titleTextMedium.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: kcWhiteColor,
                                  ),
                                ),
                                verticalSpaceSmall,
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: kcDarkGreyColor,
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                        color: kcContainerBorderColor),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      verticalSpaceMedium,
                                      Text(
                                        'Boost Your Event Visibility!',
                                        style: titleTextMedium.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: kcWhiteColor,
                                        ),
                                      ),
                                      verticalSpaceMedium,
                                      Text(
                                        'Share your event link on social media to'
                                        'reach more attendees. Events with'
                                        'engaging flyers get 2x more views!',
                                        style: titleTextMedium.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: kcGrey4Color,
                                        ),
                                      ),
                                      verticalSpaceMedium,
                                      AppButton(
                                        width: 110,
                                        labelText: 'Learn More',
                                        labelColor: kcPrimaryColor,
                                        onTap: () {},
                                        buttonColor: Colors.transparent,
                                        borderColor: kcPrimaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  @override
  HostingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HostingViewModel();
}

Widget _buildQuickStatsContainer(
    {required String title, required String value}) {
  return Container(
    height: 146,
    width: 155,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
        color: kcDarkGreyColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: kcContainerBorderColor)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: titleTextMedium.copyWith(
            fontSize: 16,
            color: kcWhiteColor,
          ),
        ),
        Text(
          value,
          style: titleTextMedium.copyWith(
            fontSize: 16,
            color: kcWhiteColor,
          ),
        ),
      ],
    ),
  );
}
