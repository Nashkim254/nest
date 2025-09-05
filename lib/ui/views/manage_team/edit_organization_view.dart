import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_dotted_container.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../models/organization_model.dart';
import '../../../utils/validators.dart';
import '../../common/app_colors.dart';
import '../../common/app_custom_button.dart';
import 'edit_organization_viewmodel.dart';

class EditOrganizationView extends StackedView<EditOrganizationViewModel> {
  const EditOrganizationView({Key? key, required this.organization}) : super(key: key);
  
  final Organization organization;

  @override
  void onViewModelReady(EditOrganizationViewModel viewModel) {
    viewModel.loadCountries();
    viewModel.initializeWithOrganization(organization);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    EditOrganizationViewModel viewModel,
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
            'Edit Organization',
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
            child: Form(
              key: viewModel.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    style: titleTextMedium.copyWith(fontSize: 16),
                    validator: (value) => Validators.validateRequired(value),
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
                    readOnly: true,
                    style: titleTextMedium.copyWith(fontSize: 16),
                    validator: (value) => Validators.validateRequired(value),
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
                    style: titleTextMedium.copyWith(fontSize: 16),
                    validator: (value) => Validators.validateRequired(value),
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
                  InkWell(
                    onTap: () => viewModel.showImageSourceSheet(
                        'banner', FileType.image),
                    child: DottedBorderContainer(
                      width: double.infinity,
                      child: viewModel.selectedBannerImage != null
                          ? Image.file(
                              viewModel.selectedBannerImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                            )
                          : viewModel.banner.isNotEmpty
                              ? Image.network(
                                  viewModel.banner,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 150,
                                    color: Colors.grey[600],
                                    child: const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                )
                          : Column(
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
                    child: InkWell(
                      onTap: () => viewModel.showImageSourceSheet(
                          'profile', FileType.image),
                      child: DottedBorderContainer(
                        width: 84,
                        height: 84,
                        borderRadius: BorderRadius.circular(50),
                        child: viewModel.selectedProfileImage != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(viewModel.selectedProfileImage!),
                              )
                            : viewModel.profilePic.isNotEmpty
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(viewModel.profilePic) as ImageProvider,
                                    onBackgroundImageError: (exception, stackTrace) {},
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  )
                            : Column(
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
                    style: titleTextMedium.copyWith(fontSize: 16),
                    validator: (value) => Validators.validateRequired(value),
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
                    style: titleTextMedium.copyWith(fontSize: 16),
                    validator: (value) => Validators.validateRequired(value),
                    controller: viewModel.bioController,
                    maxLines: 3,
                    decoration: AppInputDecoration.standard(
                      hintText: "Tell us about your organization and what "
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
                    style: titleTextMedium.copyWith(fontSize: 16),
                    validator: (value) => Validators.validateRequired(value),
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
                  DropdownButtonFormField<String>(
                    value: viewModel.selectedCountry,
                    items: viewModel.countries
                        .map((country) => DropdownMenuItem(
                              value: country,
                              child: Text(
                                country,
                                style: titleTextMedium.copyWith(
                                  color: kcWhiteColor,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) => viewModel.selectedCountry = value,
                    decoration: AppInputDecoration.standard(
                      hintText: 'Select Country',
                    ),
                    style: titleTextMedium.copyWith(
                      color: kcWhiteColor,
                    ),
                    dropdownColor: kcBackgroundColor,
                    validator: (value) => Validators.validateRequired(value),
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
                      final member = viewModel.teamMembers[index];
                      return ListTile(
                        title: Text(
                          member.name ?? 'Unknown User',
                          style: titleTextMedium.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: kcWhiteColor,
                          ),
                        ),
                        subtitle: Text(
                          member.role ?? 'Member',
                          style: titleTextMedium.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kcDisableIconColor,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close,
                              color: kcDisableIconColor),
                          onPressed: () => viewModel.removeTeamMember(index),
                        ),
                      );
                    },
                  ),
                  verticalSpaceSmall,
                  AppButton(
                    labelText: 'Add Team Member',
                    onTap: viewModel.addPeople,
                    buttonColor: Colors.transparent,
                    borderColor: kcPrimaryColor,
                    labelColor: kcPrimaryColor,
                    leadingIcon: add,
                  ),
                  verticalSpaceSmall,
                  AppButton(
                    isBusy: viewModel.isBusy,
                    labelText: 'Update Organization',
                    onTap: () => viewModel.updateOrganization(),
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
  EditOrganizationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditOrganizationViewModel();
}