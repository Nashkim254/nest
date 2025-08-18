import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/startup/widgets/dots_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                splash,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'We make it\nhappen baby!',
                    style: titleTextLarge,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Nest connects you to exclusive\nnightlife events and your favorite\nhosts.',
                    style: bodyTextMedium,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceLarge,
                  DotWidget(),
                  verticalSpaceMedium,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppButton(
                      labelText: 'Get Started',
                      onTap: () => viewModel.getStarted(),
                    ),
                  ),
                  verticalSpaceMedium,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppButton(
                      labelText: 'Skip',
                      buttonColor: Colors.transparent,
                      onTap: () => viewModel.navigateToLogin(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
