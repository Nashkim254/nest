import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';

import '../../../models/progress_segment.dart';

class StackedProgressBar extends StatelessWidget {
  const StackedProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: kcStepperColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
