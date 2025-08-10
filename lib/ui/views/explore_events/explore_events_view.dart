import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_colors.dart';
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
  Widget builder(
    BuildContext context,
    ExploreEventsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceMedium,
                TextFormField(
                  controller: viewModel.searchController,
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
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.events.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: kcDarkGreyColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: kcContainerBorderColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image section - Fixed height instead of Expanded
                            SizedBox(
                              height: 200, // Set a fixed height for the image
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.asset(
                                  viewModel.events[index].imageUrl!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            // Content section - Remove Expanded wrapper
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    viewModel.events[index].title,
                                    style: titleTextMedium.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        calendar,
                                        color: kcSubtitleColor,
                                      ),
                                      horizontalSpaceSmall,
                                      Text(
                                        viewModel.events[index].dateTime,
                                        style: titleTextMedium.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: kcSubtitleColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        pin,
                                        color: kcSubtitleColor,
                                      ),
                                      horizontalSpaceSmall,
                                      Text(
                                        viewModel.events[index].location!,
                                        style: titleTextMedium.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: kcSubtitleColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
    );
  }

  @override
  ExploreEventsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExploreEventsViewModel();
}
