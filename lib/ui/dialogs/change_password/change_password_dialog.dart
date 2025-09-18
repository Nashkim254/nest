import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'change_password_dialog_model.dart';

const double _graphicSize = 60;

class ChangePasswordDialog extends StackedView<ChangePasswordDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ChangePasswordDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChangePasswordDialogModel viewModel,
    Widget? child,
  ) {
    final isPasswordReset = request.title == 'Reset Password';

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
              if (!isPasswordReset) ...[
                Text(
                  'Current Password',
                  style: titleTextMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  style: titleTextMedium.copyWith(color: kcWhiteColor),
                  controller: viewModel.currentPasswordController,
                  decoration: AppInputDecoration.standard(
                    hintText: 'Current Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kcWhiteColor,
                      ),
                      onPressed: () {
                        viewModel.togglePasswordVisibility();
                      },
                    ),
                  ),
                  obscureText: viewModel.isPasswordVisible,
                  onChanged: (value) {},
                  validator: (value) => viewModel.validateCurrentPassword(value),
                ),
                verticalSpaceSmall,
              ],
              Text(
                'New Password',
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                style: titleTextMedium.copyWith(color: kcWhiteColor),
                controller: viewModel.newPasswordController,
                decoration: AppInputDecoration.standard(
                  hintText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kcWhiteColor,
                    ),
                    onPressed: () {
                      viewModel.toggleNewPasswordVisibility();
                    },
                  ),
                ),
                obscureText: viewModel.isNewPasswordVisible,
                onChanged: (value) {},
                validator: (value) => viewModel.validateNewPassword(value),
              ),
              verticalSpaceSmall,
              Text(
                'Confirm New Password',
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                style: titleTextMedium.copyWith(color: kcWhiteColor),
                controller: viewModel.confirmPasswordController,
                decoration: AppInputDecoration.standard(
                  hintText: 'Confirm New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kcWhiteColor,
                    ),
                    onPressed: () {
                      viewModel.toggleConfirmPasswordVisibility();
                    },
                  ),
                ),
                obscureText: viewModel.isConfirmPasswordVisible,
                onChanged: (value) {},
                validator: (value) => viewModel.validateConfirmPassword(value),
              ),
              verticalSpaceMedium,
              AppButton(
                labelText: isPasswordReset ? 'Reset Password' : 'Change Password',
                isBusy: viewModel.isLoading,
                onTap: () => isPasswordReset
                    ? viewModel.requestPasswordReset(completer)
                    : viewModel.submitForm(completer),
              ),
              verticalSpaceMedium
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChangePasswordDialogModel viewModelBuilder(BuildContext context) =>
      ChangePasswordDialogModel();
}
