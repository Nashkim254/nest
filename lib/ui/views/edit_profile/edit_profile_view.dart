import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/views/edit_profile/widgets/selector.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_enums.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileView extends StackedView<EditProfileViewModel> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditProfileViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: kcDarkColor,
          title: Text(
            "Edit Profile",
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                // Handle share action
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Saved',
                  style: titleTextMedium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                const Align(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(avatar),
                    backgroundColor: kcPrimaryColor,
                  ),
                ),
                verticalSpaceSmall,
                Align(
                  child: Text(
                    "Edit Photo",
                    style: titleTextMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kcPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  "General",
                  style: titleTextMedium.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceMedium,
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: kcDarkGreyColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kcContainerBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name",
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: kcWhiteColor,
                            ),
                          ),
                          Text(
                            "John Doe",
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: kcDisableIconColor,
                            ),
                          ),
                        ],
                      ),
                      spacedDivider,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Username",
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: kcWhiteColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: viewModel.usernameController,
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: kcWhiteColor,
                              ),
                              textAlign: TextAlign.end,
                              decoration: AppInputDecoration.standard(
                                fillColor: kcDarkGreyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      spacedDivider,
                      Text(
                        "Bio",
                        style: titleTextMedium.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kcWhiteColor,
                        ),
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: viewModel.bioController,
                        style: titleTextMedium.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: kcWhiteColor,
                        ),
                        maxLines: 3,
                        decoration: AppInputDecoration.standard(
                          hintText: 'Username',
                          fillColor: kcDarkGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  "Socials",
                  style: titleTextMedium.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceMedium,
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: kcDarkGreyColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kcContainerBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Instagram",
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: kcWhiteColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: viewModel.igController,
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: kcWhiteColor,
                              ),
                              textAlign: TextAlign.end,
                              decoration: AppInputDecoration.standard(
                                fillColor: kcDarkGreyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      spacedDivider,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "X (Twitter)",
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: kcWhiteColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: viewModel.xController,
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: kcWhiteColor,
                              ),
                              textAlign: TextAlign.end,
                              decoration: AppInputDecoration.standard(
                                fillColor: kcDarkGreyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      spacedDivider,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "LinkedIn",
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: kcWhiteColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: viewModel
                                  .linkedInController, // Add controller
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: kcWhiteColor,
                              ),
                              textAlign: TextAlign.end,
                              decoration: AppInputDecoration.standard(
                                  fillColor: kcDarkGreyColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  "Settings",
                  style: titleTextMedium.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceMedium,
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: kcDarkGreyColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kcContainerBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Show Events I’m Attending",
                        style: titleTextMedium.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kcWhiteColor,
                        ),
                      ),
                      spacedDivider,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: SettingsType.values.map((type) {
                          return buildSettingsSelector(
                            label: type.name,
                            isSelected: viewModel.settingsType == type,
                            onTap: () => viewModel.selectSettingsType(type),
                          );
                        }).toList(),
                      ),
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Show me on Guest Lists",
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: kcWhiteColor,
                            ),
                          ),
                          Switch(
                            value: viewModel.isPrivateAccount,
                            onChanged: (value) {
                              viewModel.togglePrivateAccount();
                            },
                            activeColor: kcWhiteColor,
                            activeTrackColor: kcPrimaryColor,
                          ),
                        ],
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
  EditProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditProfileViewModel();
}
