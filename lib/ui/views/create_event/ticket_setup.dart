import 'package:flutter/material.dart';
import 'package:nest/ui/views/create_event/progress_bar.dart';

import '../../common/app_colors.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';

class TicketSetup extends StatelessWidget {
  const TicketSetup({super.key, required this.viewModel});
  final CreateEventViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: kcContainerBorderColor,
                  width: 1.0,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  title: Text(
                    'Guestlist',
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kcWhiteColor,
                    ),
                  ),
                  iconColor: kcWhiteColor,
                  collapsedIconColor: kcWhiteColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: kcContainerBorderColor,
                          ),
                          Text(
                            'Quantity Limit (Optional)',
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kcWhiteColor,
                            ),
                          ),
                          verticalSpaceSmall,
                          TextFormField(
                            decoration: AppInputDecoration.standard(
                              hintText: "e.g., '100'",
                              filled: true,
                            ),
                          ),
                          verticalSpaceMedium,
                          Text(
                            'Description (Optional)',
                            style: titleTextMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kcWhiteColor,
                            ),
                          ),
                          verticalSpaceSmall,
                          TextFormField(
                            maxLines: 3,
                            decoration: AppInputDecoration.standard(
                              hintText:
                                  "e.g., Grants access to the main event area.",
                              filled: true,
                            ),
                          ),
                          verticalSpaceMedium,
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            value: viewModel.isMax1PerUser,
                            onChanged: (value) =>
                                viewModel.isMax1PerUser = value!,
                            title: Text(
                              'Max 1 per user',
                              style: titleTextMedium.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kcWhiteColor,
                              ),
                            ),
                            activeColor: kcPrimaryColor,
                            checkColor: kcWhiteColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
