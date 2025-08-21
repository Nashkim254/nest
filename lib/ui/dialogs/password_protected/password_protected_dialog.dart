import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import 'password_protected_dialog_model.dart';

const double _graphicSize = 60;

class PasswordProtectedDialog
    extends StackedView<PasswordProtectedDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PasswordProtectedDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PasswordProtectedDialogModel viewModel,
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
                'Password',
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcWhiteColor,
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                style: titleTextMedium.copyWith(color: kcWhiteColor),
                controller: viewModel.passwordController,
                decoration: AppInputDecoration.standard(
                  hintText: 'Password',
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
              verticalSpaceMedium,
              AppButton(
                labelText: 'Proceed',
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
  PasswordProtectedDialogModel viewModelBuilder(BuildContext context) =>
      PasswordProtectedDialogModel();
}
