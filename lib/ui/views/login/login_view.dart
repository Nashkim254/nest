import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import 'login_view.form.dart';
import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
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
                    "Welcome back!\nLog in to continue partying.",
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kcGreyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: emailController,
                  decoration:
                      AppInputDecoration.standard(hintText: 'Email or Phone'),
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: passwordController,
                  decoration: AppInputDecoration.standard(hintText: 'Password'),
                ),
                verticalSpaceMedium,
                AppButton(
                  labelText: 'Login',
                  onTap: () => viewModel.login(),
                ),
                verticalSpaceMedium,
                Align(
                  child: Text(
                    "Forgot Password?",
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kcGreyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(child: spacedDivider),
                    horizontalSpaceSmall,
                    Text(
                      "OR CONTINUE WITH",
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
                verticalSpaceMedium,
                AppButton(
                  labelText: 'Continue with Google',
                  onTap: () {},
                  buttonColor: kcOffWhite8Grey,
                  borderColor: kcContainerBorderColor,
                  leadingIcon: chrome,
                ),
                verticalSpaceSmall,
                AppButton(
                  labelText: 'Continue with Apple',
                  onTap: () {},
                  buttonColor: kcOffWhite8Grey,
                  borderColor: kcContainerBorderColor,
                  leadingIcon: apple,
                ),
                verticalSpaceSmall,
                AppButton(
                  labelText: 'Login with WhatsApp',
                  onTap: () {},
                  buttonColor: kcOffWhite8Grey,
                  borderColor: kcContainerBorderColor,
                  leadingIcon: whatsapp,
                ),
                verticalSpaceMedium,
                Align(
                  child: Text(
                    "Don't have an account?",
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kcGreyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  child: Text(
                    "Sign up",
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kcPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
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
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
