import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import 'add_social_dialog_model.dart';

const double _graphicSize = 60;

class AddSocialDialog extends StackedView<AddSocialDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddSocialDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddSocialDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: kcContainerColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: viewModel.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Social',
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              //drop down for social type
              DropdownButtonFormField<String>(
                value: viewModel.selectedSocialType,
                items: viewModel.socialTypes
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: titleTextMedium.copyWith(
                              color: kcWhiteColor,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    viewModel.selectedSocialType = value;
                  }
                },
                decoration: AppInputDecoration.standard(
                  hintText: 'Select Social Type',
                ),
                style: titleTextMedium.copyWith(
                  color: kcWhiteColor,
                ),
                dropdownColor: kcBackgroundColor,
              ),

              verticalSpaceSmall,
              Text(
                'Social Media Link',
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                style: titleTextMedium.copyWith(color: kcWhiteColor),
                controller: viewModel.socialLinkController,
                decoration: AppInputDecoration.standard(
                  hintText: 'e.g https://twitter.com/yourprofile',
                ),
                onChanged: (value) {},
                validator: (value) => Validators.validateRequired(value),
              ),
              verticalSpaceMedium,
              AppButton(
                labelText: 'Add Social',
                isBusy: viewModel.isBusy,
                onTap: () => viewModel.submitForm(completer),
              ),
              verticalSpaceMedium
            ],
          ),
        ),
      ),
    );
  }

  @override
  AddSocialDialogModel viewModelBuilder(BuildContext context) =>
      AddSocialDialogModel();
}
