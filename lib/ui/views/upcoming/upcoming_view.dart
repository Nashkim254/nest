import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/upcoming/widgets/my_tickets.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'upcoming_viewmodel.dart';

class UpcomingView extends StackedView<UpcomingViewModel> {
  const UpcomingView({Key? key}) : super(key: key);

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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.21,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      viewModel.getSampleTickets().length,
                      (int i) => MyTicketWidget(
                        ticket: viewModel.getSampleTickets()[i],
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
                        height: 30,
                        labelText: 'View all',
                        onTap: () => viewModel.viewAllPeopleAndOrgs(),
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      2,
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
                              const CircleAvatar(),
                              horizontalSpaceSmall,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sarah & 2 others',
                                    style: titleTextMedium.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'going to "Electro Groove"',
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
                        height: 30,
                        labelText: 'View all',
                        onTap: () => viewModel.viewAllEvents(),
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      2,
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
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(13),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        ev2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Summer Fest 2023',
                                      style: titleTextMedium.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Aug 15, 2023',
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
                                    onTap: () => viewModel.viewEventDetails(),
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
