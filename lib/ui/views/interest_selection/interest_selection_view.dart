import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/startup/widgets/dots_widget.dart';
import 'package:stacked/stacked.dart';

import 'interest_selection_viewmodel.dart';

class InterestSelectionView extends StackedView<InterestSelectionViewModel> {
  const InterestSelectionView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InterestSelectionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "What Are You Into?",
                style: titleTextMedium.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kcWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpaceSmall,
              Text(
                "Pick genres and events you love. We’ll personalize your feed.",
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  color: kcSubtitleTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpaceSmall,
              DotWidget(),
              verticalSpaceSmall,
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: viewModel.interests.map((interest) {
                      final isSelected =
                          viewModel.selectedInterests.contains(interest);
                      return GestureDetector(
                        onTap: () => viewModel.toggleInterest(interest),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? kcPrimaryColor : kcDarkGreyColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            interest,
                            style: titleTextMedium.copyWith(
                              color: kcWhiteColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              verticalSpaceMedium,
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  labelText: 'Next',
                  onTap: () => viewModel.submitInterests(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  InterestSelectionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      InterestSelectionViewModel();
}
