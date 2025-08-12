import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_custom_button.dart';
import '../../../common/app_enums.dart';
import '../../../common/app_strings.dart';
import '../../../common/ui_helpers.dart';
import '../hosting_viewmodel.dart';
import 'event_card.dart';

class UpcomingTab extends StatelessWidget {
  const UpcomingTab({super.key, required this.viewModel});
  final HostingViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceMedium,
        ],
      ),
      floatingActionButton: AppButton(
        width: 200,
        leadingIcon: add,
        labelText: 'Create New Event',
        onTap: () {},
      ),
    );
  }
}
