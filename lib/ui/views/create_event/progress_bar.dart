import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';

import '../../../models/progress_segment.dart';


class StackedProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final double height;

  const StackedProgressBar({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: kcStepperColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Row(
        children: List.generate(totalSteps, (index) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: index < totalSteps - 1 ? 2 : 0,
              ),
              decoration: BoxDecoration(
                color: index < currentStep ? kcPrimaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          );
        }),
      ),
    );
  }
}