import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_dotted_container.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_custom_button.dart';
import 'create_organization_viewmodel.dart';

class CreateOrganizationView extends StackedView<CreateOrganizationViewModel> {
  const CreateOrganizationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateOrganizationViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          backgroundColor: kcDarkColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => viewModel.navigationService.back(),
            icon: Icon(
              Icons.adaptive.arrow_back_outlined,
              color: kcWhiteColor,
            ),
          ),
          elevation: 0,
          title: const Text(
            'Create Organization',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Organization Details',
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'Organization Name',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: viewModel.organizationNameController,
                  decoration: AppInputDecoration.standard(
                    hintText: "Enter unique organization name",
                    filled: true,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Social Media Links',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: viewModel.organizationSocialController,
                  decoration: AppInputDecoration.standard(
                    hintText: "Instagram",
                    filled: true,
                  ),
                ),
                verticalSpaceSmall,
                AppButton(
                  labelText: 'Add Social Media',
                  onTap: viewModel.addSocialMediaLink,
                  buttonColor: Colors.transparent,
                  borderColor: kcPrimaryColor,
                  labelColor: kcPrimaryColor,
                  leadingIcon: add,
                ),
                verticalSpaceSmall,
                Text(
                  'Contact Info',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: viewModel.organizationContactController,
                  maxLines: 3,
                  decoration: AppInputDecoration.standard(
                    hintText: "Email, phone number, or website",
                    filled: true,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Branding',
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Banner Image',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                DottedBorderContainer(
                  width: double.infinity,
                  child: Column(
                    children: [
                      verticalSpaceMedium,
                      const Icon(
                        Icons.add_photo_alternate_outlined,
                        color: kcDisableIconColor,
                        size: 40,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Drag & drop or click to upload banner',
                        style: titleTextMedium.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kcDisableIconColor,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Profile Picture',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                Align(
                  child: DottedBorderContainer(
                    width: 84,
                    height: 84,
                    borderRadius: BorderRadius.circular(50),
                    child: Column(
                      children: [
                        verticalSpaceMedium,
                        const Icon(
                          Icons.person,
                          color: kcDisableIconColor,
                          size: 20,
                        ),
                        Text(
                          'Upload',
                          style: titleTextMedium.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kcDisableIconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'About Your Organization',
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Business',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: viewModel.businessController,
                  maxLines: 3,
                  decoration: AppInputDecoration.standard(
                    hintText:
                        "e.g., Restaurant, Club, Sorority, Individual, other...",
                    filled: true,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Bio',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: viewModel.bioController,
                  maxLines: 3,
                  decoration: AppInputDecoration.standard(
                    hintText: "Tell us about your organization and what"
                        'you do',
                    filled: true,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Genres',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: viewModel.genreController,
                  decoration: AppInputDecoration.standard(
                    hintText: "e.g., EDM, Hip-Hop, Rock (comma separated)",
                    filled: true,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  'Country',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcDisableIconColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: viewModel.countryController,
                  decoration: AppInputDecoration.standard(
                    hintText: "Select Country",
                    filled: true,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'Team Members',
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceSmall,
                ListView.builder(
                  itemCount: viewModel.teamMembers.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        viewModel.teamMembers[index].name!,
                        style: titleTextMedium.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: kcWhiteColor,
                        ),
                      ),
                      subtitle: Text(
                        viewModel.teamMembers[index].role!,
                        style: titleTextMedium.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: kcDisableIconColor,
                        ),
                      ),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.close, color: kcDisableIconColor),
                        onPressed: () => viewModel.removeTeamMember(index),
                      ),
                    );
                  },
                ),
                verticalSpaceSmall,
                AppButton(
                  labelText: 'Add Team Member',
                  onTap: viewModel.addSocialMediaLink,
                  buttonColor: Colors.transparent,
                  borderColor: kcPrimaryColor,
                  labelColor: kcPrimaryColor,
                  leadingIcon: add,
                ),
                verticalSpaceSmall,
                AppButton(
                  labelText: 'Create Organization',
                  onTap: viewModel.addSocialMediaLink,
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
  CreateOrganizationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateOrganizationViewModel();
}
