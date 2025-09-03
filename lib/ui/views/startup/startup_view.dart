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
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                // Image Section
                Container(
                  height: screenHeight * 0.4, // 50% of screen height
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(splash),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),

                      // Title
                      Text(
                        'We make it\nhappen baby!',
                        style: titleTextLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Subtitle
                      Text(
                        'Nest connects you to exclusive\nnightlife events and your favorite\nhosts.',
                        style: bodyTextMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Dots indicator
                       DotWidget(),
                      const SizedBox(height: 32),

                      // Get Started Button
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          labelText: 'Get Started',
                          onTap:() => viewModel.getStarted(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Skip Button
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          labelText: 'Skip',
                          buttonColor: Colors.transparent,
                          onTap: () => viewModel.navigateToLogin(),
                        ),
                      ),
                      const SizedBox(height: 20),
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
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}