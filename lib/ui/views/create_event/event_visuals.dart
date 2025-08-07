import 'package:flutter/material.dart';
import 'package:nest/ui/views/create_event/progress_bar.dart';

import '../../common/app_colors.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';

class EventVisuals extends StatelessWidget {
  const EventVisuals({super.key, required this.viewModel});
  final CreateEventViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket Setup',
              style: titleTextMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
