import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/startup/widgets/dots_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);
  @override
  onViewModelReady(StartupViewModel viewModel) => viewModel.onViewModelReady();
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
                // Image Section with gradient blend
                Container(
                  height:
                      screenHeight * 0.4, // Increased height for better blend
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(splash),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          kcDarkColor.withValues(alpha: 0.3),
                          kcDarkColor.withValues(alpha: 0.7),
                          kcDarkColor,
                        ],
                        stops: const [0.0, 0.5, 0.7, 0.85, 1.0],
                      ),
                    ),
                  ),
                ),

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Reduced spacing for seamless blend
                      const SizedBox(height: 0),

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
                      const SizedBox(height: 24),

                      // Get Started Button
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          labelText: 'Get Started',
                          onTap: () => viewModel.getStarted(),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Skip Button
                      SizedBox(
                        width: double.infinity,
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
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
