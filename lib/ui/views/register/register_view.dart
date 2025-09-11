import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/models/registration_model.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/views/register/register_view.form.dart';
import 'package:nest/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../app/app.locator.dart';
import '../../../services/auth_service.dart';
import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'register_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
  FormTextField(name: 'phone'),
  FormTextField(name: 'name'),
])
class RegisterView extends StackedView<RegisterViewModel> with $RegisterView {
  const RegisterView({Key? key, required this.registrationModel})
      : super(key: key);
  final RegistrationModel registrationModel;
  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  Align(
                    child: SvgPicture.asset(logo),
                  ),
                  verticalSpaceSmall,
                  Align(
                    child: Text(
                      "Join the party! Create your\naccount.",
                      style: titleTextMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kcGreyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // verticalSpaceMedium,
                  // Align(
                  //   child: Container(
                  //     height: 98,
                  //     width: 98,
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(color: kcContainerBorderColor),
                  //         color: kcProfileColor),
                  //     child: Center(
                  //       child: SvgPicture.asset(
                  //         camera,
                  //         height: 24,
                  //         width: 24,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // verticalSpaceMedium,
                  // Align(
                  //   child: Text(
                  //     'Upload Profile Picture',
                  //     style: titleTextMedium.copyWith(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //       color: kcGreyColor,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  verticalSpaceMedium,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: nameController,
                    decoration: AppInputDecoration.standard(
                        hintText: 'Name', borderColor: kcBorderColor),
                    validator: (value) => Validators.validateRequired(value),
                  ),
                  verticalSpaceMedium,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: emailController,
                    validator: (value) => Validators.validateEmail(value),
                    decoration: AppInputDecoration.standard(
                        hintText: 'Email', borderColor: kcBorderColor),
                  ),
                  verticalSpaceMedium,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: phoneController,
                    validator: (value) => Validators.validatePhone(value),
                    decoration: AppInputDecoration.standard(
                        hintText: 'Phone', borderColor: kcBorderColor),
                  ),
                  verticalSpaceMedium,
                  TextFormField(
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                    controller: passwordController,
                    validator: (value) => Validators.validatePassword(value),
                    obscureText: viewModel.isPasswordVisible,
                    decoration: AppInputDecoration.standard(
                      hintText: 'Password',
                      borderColor: kcBorderColor,
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
                  ),
                  verticalSpaceMedium,
                  AppButton(
                    isBusy: viewModel.isRegistering,
                    labelText: 'Create My Account',
                    onTap: () => viewModel.register(
                      registrationModel,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: spacedDivider),
                      horizontalSpaceSmall,
                      Text(
                        "OR",
                        style: titleTextMedium.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kcGreyColor,
                        ),
                      ),
                      horizontalSpaceSmall,
                      Expanded(child: spacedDivider),
                    ],
                  ),
                  AppButton(
                    labelText: 'Continue with Google',
                    isBusy: viewModel.isBusy,
                    onTap: () async =>
                        await locator<AuthService>().signInWithGoogle().then(
                              (value) async =>
                                  await viewModel.sendAuthGoogleParams(value),
                            ),
                    buttonColor: kcOffWhite8Grey,
                    borderColor: kcBorderColor,
                    leadingIcon: chrome,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'By signing up, you agree to our Terms & Privacy',
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kcGreyColor,
                    ),
                  ),
                  Align(
                    child: Text(
                      "Already have an account?",
                      style: titleTextMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kcGreyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    child: TextButton(
                      onPressed: () => viewModel.signin(),
                      child: Text(
                        "Sign in",
                        style: titleTextMedium.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kcPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();
}
