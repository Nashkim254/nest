import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/views/create_event/progress_bar.dart';

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
          ],
        ),
      ),
    );
  }
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
