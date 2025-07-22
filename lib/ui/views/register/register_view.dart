import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/views/register/register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

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
  const RegisterView({Key? key}) : super(key: key);

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
                verticalSpaceMedium,
                Align(
                  child: Container(
                    height: 98,
                    width: 98,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kcContainerBorderColor),
                        color: kcProfileColor),
                    child: Center(
                      child: SvgPicture.asset(
                        camera,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Align(
                  child: Text(
                    'Upload Profile Picture',
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
                  controller: nameController,
                  decoration: AppInputDecoration.standard(
                      hintText: 'Name', borderColor: kcBorderColor),
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: emailController,
                  decoration: AppInputDecoration.standard(
                      hintText: 'Email', borderColor: kcBorderColor),
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: phoneController,
                  decoration: AppInputDecoration.standard(
                      hintText: 'Phone', borderColor: kcBorderColor),
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: passwordController,
                  decoration: AppInputDecoration.standard(
                      hintText: 'Password', borderColor: kcBorderColor),
                ),
                verticalSpaceMedium,
                AppButton(
                  labelText: 'Create My Account',
                  onTap: () {},
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
                  onTap: () {},
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
              ],
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
