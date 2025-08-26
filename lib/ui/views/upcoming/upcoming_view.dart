import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/upcoming/widgets/my_tickets.dart';
import 'package:nest/utils/utilities.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'upcoming_viewmodel.dart';

class UpcomingView extends StackedView<UpcomingViewModel> {
  const UpcomingView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(UpcomingViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    UpcomingViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'My Tickets',
                  style: titleTextMedium,
                ),
                verticalSpaceSmall,
                viewModel.tickets.isEmpty
                    ? Center(
                        child: Text(
                          'No tickets at the moment',
                          style: titleTextMedium.copyWith(
                            fontSize: 16,
                            color: kcGreyColor,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.21,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            viewModel.tickets.length,
                            (int i) => MyTicketWidget(
                              ticket: viewModel.tickets[i],
                            ),
                          ),
                        ),
                      ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'People & Organizations',
                      style: titleTextMedium,
                    ),
                    SizedBox(
                      width: 100,
                      child: AppButton(
                        buttonColor: !viewModel.hasOrganizations
                            ? kcGreyButtonColor
                            : kcPrimaryColor,
                        height: 30,
                        labelText: 'View all',
                        onTap: viewModel.hasOrganizations
                            ? () => viewModel.viewAllPeopleAndOrgs()
                            : () {},
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                if (!viewModel.hasOrganizations)
                  Center(
                    child: Text(
                      'No organizations at the moment',
                      style: titleTextMedium.copyWith(
                        fontSize: 16,
                        color: kcGreyColor,
                      ),
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      viewModel.myOrganizations.length,
                      (int i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kcDarkGreyColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: kcContainerBorderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    viewModel.myOrganizations[i].profilePic!),
                              ),
                              horizontalSpaceSmall,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${viewModel.myOrganizations[i].teamMembers!.first.name ?? '--'} ${viewModel.myOrganizations[i].teamMembers!.length - 1 > 0 ? 'and ${viewModel.myOrganizations[i].teamMembers!.length - 1} others' : ''}",
                                    style: titleTextMedium.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'going to "${viewModel.myOrganizations[i].name}" events',
                                    style: titleTextMedium.copyWith(
                                        fontSize: 13, color: kcGreyColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Events',
                      style: titleTextMedium,
                    ),
                    SizedBox(
                      width: 100,
                      child: AppButton(
                        buttonColor: viewModel.upcomingEvents.isEmpty
                            ? kcGreyButtonColor
                            : kcPrimaryColor,
                        height: 30,
                        labelText: 'View all',
                        onTap: viewModel.upcomingEvents.isEmpty
                            ? () {}
                            : () => viewModel.viewAllEvents(),
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                if (viewModel.upcomingEvents.isEmpty)
                  Center(
                    child: Text(
                      'No events at  the moment',
                      style: titleTextMedium.copyWith(
                        fontSize: 16,
                        color: kcGreyColor,
                      ),
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      viewModel.upcomingEvents.take(2).length,
                      (int i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kcDarkGreyColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: kcContainerBorderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(13),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        viewModel.upcomingEvents[i].flyerUrl,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.upcomingEvents[i].title,
                                      style: titleTextMedium.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      formatter.format(viewModel
                                          .upcomingEvents[i].startTime),
                                      style: titleTextMedium.copyWith(
                                          fontSize: 13, color: kcGreyColor),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 100,
                                  child: AppButton(
                                    labelText: 'View',
                                    onTap: () => viewModel.viewEventDetails(
                                        viewModel.upcomingEvents[i]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
        floatingActionButton: AppButton(
          width: 200,
          leadingIcon: search,
          labelText: 'Find Events',
          onTap: () => viewModel.findEvents(),
        ),
      ),
    );
  }

  @override
  UpcomingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UpcomingViewModel();
}
