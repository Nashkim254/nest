import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';

import '../../common/app_colors.dart';
import '../../common/app_dotted_container.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';

class EventVisuals extends StatelessWidget {
  const EventVisuals({super.key, required this.viewModel});
  final CreateEventViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flyer Upload',
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  spacedDivider,
                  InkWell(
                    onTap: () => viewModel.showImageSourceSheet(),
                    child: DottedBorderContainer(
                      borderColor: kcContainerBorderColor,
                      height: 200,
                      width: double.infinity,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            verticalSpaceSmall,
                            if (viewModel.isBusy)
                              const CircularProgressIndicator(
                                color: kcPrimaryColor,
                              )
                            else ...[
                              SvgPicture.asset(addImg),
                              verticalSpaceSmall,
                              Text(
                                "Drag & drop your flyer here or",
                                style: titleTextMedium.copyWith(
                                  fontSize: 15,
                                  color: kcFollowColor,
                                ),
                              ),
                              verticalSpaceSmall,
                              AppButton(
                                width: 150,
                                buttonColor: Colors.transparent,
                                borderColor: kcPrimaryColor,
                                labelText: 'Browse Files',
                                onTap: () {},
                              )
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Theme Preview',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                    ),
                  ),
                  spacedDivider,
                  Text(
                    'Based on your flyer, we suggest this'
                    'theme:',
                    style: titleTextMedium.copyWith(
                      color: kcSubtitleColor,
                    ),
                  ),
                  verticalSpaceMedium,
                  buildThemeSelection(viewModel),
                ],
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event Description',
                    style: titleTextMedium.copyWith(
                        color: kcWhiteColor, fontSize: 17),
                  ),
                  spacedDivider,
                  Text(
                    'Description',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: viewModel.descriptionController,
                    maxLines: 5,
                    decoration: AppInputDecoration.standard(
                      hintText: 'Tell attendees about your event: '
                          'vibe, dress code, special notes...',
                      fillColor: kcDarkGreyColor,
                      filled: true,
                    ),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lineup',
                    style: titleTextMedium.copyWith(
                        color: kcWhiteColor, fontSize: 17),
                  ),
                  spacedDivider,
                  Text(
                    'Performer Name',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: viewModel.performerController,
                    decoration: AppInputDecoration.standard(
                      hintText: 'e.g., DJ Sparkle',
                      fillColor: kcDarkGreyColor,
                      filled: true,
                    ),
                    onChanged: (value) {},
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Performer Image',
                    style: titleTextMedium.copyWith(
                        color: kcWhiteColor, fontSize: 17),
                  ),
                  verticalSpaceSmall,
                  DottedBorderContainer(
                    height: 64,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (viewModel.isPerformerImageLoading)
                          const CircularProgressIndicator(
                            color: kcPrimaryColor,
                          )
                        else ...[
                          SvgPicture.asset(addImg),
                          horizontalSpaceSmall,
                          Text(
                            "Add Performer Image",
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              color: kcFollowColor,
                            ),
                          ),
                          verticalSpaceSmall,
                        ],
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Performance Time',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: viewModel.performanceTimeController,
                    decoration: AppInputDecoration.standard(
                      hintText: 'e.g., 10:00 PM – 11:30 PM',
                      fillColor: kcDarkGreyColor,
                      filled: true,
                    ),
                    onChanged: (value) {},
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Website URL (Optional)',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: viewModel.performanceTimeController,
                    decoration: AppInputDecoration.standard(
                      hintText: 'e.g., https://djsparkle.com',
                      fillColor: kcDarkGreyColor,
                      filled: true,
                    ),
                    onChanged: (value) {},
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Instagram Profile (Optional)',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: viewModel.igController,
                    decoration: AppInputDecoration.standard(
                      hintText: 'e.g., @djsparkle',
                      fillColor: kcDarkGreyColor,
                      filled: true,
                    ),
                    onChanged: (value) {},
                  ),
                  verticalSpaceMedium,
                  AppButton(
                    labelText: 'Add Performer',
                    onTap: () {},
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Current Lineup',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpaceMedium,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: kcPrimaryColor,
                          child: Image.asset(
                            viewModel.performers[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          viewModel.performers[index].name,
                          style: titleTextMedium.copyWith(
                            color: kcWhiteColor,
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              viewModel.performers[index].time,
                              style: titleTextMedium.copyWith(
                                color: kcSubtitleColor,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 34,
                                  width: 34,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: kcGreyButtonColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: SvgPicture.asset(
                                    web,
                                    color: kcDisableIconColor,
                                  ),
                                ),
                                horizontalSpaceSmall,
                                Container(
                                  height: 34,
                                  width: 34,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: kcGreyButtonColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: SvgPicture.asset(
                                    instagram,
                                    color: kcDisableIconColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: kcDisableIconColor,
                          ),
                          onPressed: () {
                            viewModel.removePerformer(index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, int index) {
                      return const SizedBox(
                        height: 8.0,
                      );
                    },
                    itemCount: viewModel.performers.length,
                  )
                ],
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Photo Gallery',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 17,
                    ),
                  ),
                  spacedDivider,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: viewModel.selectedImages.length +
                        1, // +1 for the add button
                    itemBuilder: (context, index) {
                      if (index < viewModel.selectedImages.length) {
                        // Photo item
                        return _buildPhotoItem(
                            viewModel.selectedImages[index].path);
                      } else {
                        // Add photos button
                        return _buildAddPhotosButton(viewModel);
                      }
                    },
                  ),
                  verticalSpaceMedium,
                  Align(
                    child: AppButton(
                      width: 187,
                      buttonColor: Colors.transparent,
                      borderColor: kcPrimaryColor,
                      labelText: 'Upload More Photos',
                      labelColor: kcPrimaryColor,
                      onTap: viewModel.showImageSourceSheet,
                    ),
                  )
                ],
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sponsor Tagging',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 17,
                    ),
                  ),
                  spacedDivider,
                  Text(
                    'Sponsor Name / Logo URL',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpaceSmall,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          style: titleTextMedium.copyWith(color: kcWhiteColor),
                          controller: viewModel.sponsorController,
                          decoration: AppInputDecoration.standard(
                            hintText: 'e.g., Red Bull, or image URL',
                            fillColor: kcDarkGreyColor,
                            filled: true,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: AppButton(
                          labelText: 'Add',
                          onTap: () {
                            viewModel
                                .addSponsor(viewModel.sponsorController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  //display current sponsors  in dynamic list of chips
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: viewModel.sponsors.map((sponsor) {
                      return Chip(
                        label: Text(
                          sponsor,
                          style: titleTextMedium.copyWith(
                            color: kcWhiteColor,
                          ),
                        ),
                        backgroundColor: kcGreyButtonColor,
                        deleteIconColor: kcDisableIconColor,
                        deleteIcon: const Icon(
                          Icons.close,
                          color: kcDisableIconColor,
                        ),
                        onDeleted: () {
                          viewModel.removeSponsor(sponsor);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kcGreyButtonColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event Options',
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  spacedDivider,
                  // Scheduled Ticket Drop Countdown
                  _buildSwitchTile(
                    title: 'Scheduled Ticket Drop\nCountdown',
                    value: viewModel.scheduledTicketDrop,
                    onChanged: (value) {
                      viewModel.scheduledTicketDrop = value;
                      viewModel.rebuildUi();
                    },
                  ),

                  verticalSpaceSmall,

                  // Show Guest List
                  _buildSwitchTile(
                    title: 'Show Guest List',
                    value: viewModel.showGuestList,
                    hasInfoIcon: true,
                    onChanged: (value) {
                      viewModel.showGuestList = value;
                      viewModel.rebuildUi();
                    },
                  ),

                  verticalSpaceSmall,

                  // Show on Explore Page
                  _buildSwitchTile(
                    title: 'Show on Explore Page',
                    value: viewModel.showOnExplorePage,
                    hasInfoIcon: true,
                    onChanged: (value) {
                      viewModel.showOnExplorePage = value;
                      viewModel.rebuildUi();
                    },
                  ),

                  verticalSpaceSmall,

                  // Password Protected Event
                  _buildSwitchTile(
                    title: 'Password Protected Event',
                    value: viewModel.passwordProtected,
                    hasInfoIcon: true,
                    onChanged: (value) {
                      viewModel.passwordProtected = value;
                      viewModel.rebuildUi();
                    },
                  ),

                  verticalSpaceSmall,

                  _buildNavigationTile(
                    title: 'Terms of Service',
                    onTap: () {},
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Displays the list of attendees who have opted'
                    'in to be visible.',
                    style: titleTextMedium.copyWith(
                      color: kcSubtitleColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpaceSmall,
            AppButton(
              labelText: 'Finish & Publish',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNavigationTile({
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
            size: 24,
          ),
        ],
      ),
    ),
  );
}

Widget _buildSwitchTile({
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
  bool hasInfoIcon = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(title,
                  style: titleTextMedium.copyWith(
                    color: kcWhiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )),
              if (hasInfoIcon) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.info_outline,
                  color: kcDisableIconColor,
                  size: 18,
                ),
              ],
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: kcPrimaryColor,
          inactiveThumbColor: kcWhiteColor,
          inactiveTrackColor: kcStepperColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    ),
  );
}

Widget _buildPhotoItem(String imagePath) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFF3A3A3A),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: kcGreyButtonColor,
                child: const Icon(
                  Icons.broken_image,
                  color: kcDisableIconColor,
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildAddPhotosButton(CreateEventViewModel viewModel) {
  return GestureDetector(
    onTap: viewModel.showImageSourceSheet,
    child: DottedBorderContainer(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
            color: kcDisableIconColor,
          ),
          verticalSpaceSmall,
          Text(
            'Add Photo',
            style: titleTextMedium.copyWith(
              fontSize: 14,
              color: kcDisableIconColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildThemeSelection(CreateEventViewModel viewModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      viewModel.themeColors.length,
      (index) => InkWell(
        onTap: () => viewModel.selectThemeColorByIndex(index),
        child: Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: viewModel.themeColors[index],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: viewModel.selectedThemeIndex == index
                  ? kcPrimaryColor
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
      ),
    ),
  );
}
