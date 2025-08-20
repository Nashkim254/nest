import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';

import '../../../common/app_enums.dart';
import '../hosting_viewmodel.dart';
import 'event_card.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key, required this.viewModel});
  final HostingViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: const Column(
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
