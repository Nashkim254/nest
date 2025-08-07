import 'package:flutter/material.dart';
import 'package:nest/ui/views/create_event/progress_bar.dart';

import '../../common/app_colors.dart';
import '../../common/app_custom_button.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.viewModel});
  final CreateEventViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event title',
              style: titleTextMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              decoration: AppInputDecoration.standard(
                hintText: "e.g., 'Neon Night Rave'",
                filled: true,
              ),
            ),
            verticalSpaceMedium,
            Text(
              'Date & Time',
              style: titleTextMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              decoration: AppInputDecoration.standard(
                hintText: 'mm/dd/yyyy ---:---',
                filled: true,
              ),
            ),
            verticalSpaceMedium,
            Text(
              'Location',
              style: titleTextMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              decoration: AppInputDecoration.standard(
                hintText: "e.g., 'The Warehouse, Brooklyn'",
                filled: true,
              ),
            ),
            verticalSpaceMedium,
            Text(
              'Event Mode',
              style: titleTextMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: kcStepperColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => viewModel.togglePaidTickets(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: viewModel.isRsvP
                              ? kcPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'RSVP Only',
                          style: titleTextMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: viewModel.isRsvP
                                ? kcWhiteColor
                                : kcDisableIconColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => viewModel.togglePaidTickets(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: viewModel.isPaid
                              ? kcPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Paid Tickets',
                          style: titleTextMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: viewModel.isPaid
                                ? kcWhiteColor
                                : kcDisableIconColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Private Event',
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                Switch(
                  value: viewModel.isPrivate,
                  onChanged: (value) => viewModel.togglePrivate(),
                  activeColor: kcWhiteColor,
                  activeTrackColor: kcPrimaryColor,
                  inactiveThumbColor: kcWhiteColor,
                  inactiveTrackColor: kcStepperColor,
                ),
              ],
            ),
            verticalSpaceMedium,
            viewModel.isPrivate
                ? TextFormField(
                    decoration: AppInputDecoration.standard(
                      hintText: "Enter Password",
                      filled: true,
                    ),
                  )
                : const SizedBox.shrink(),
            verticalSpaceMedium,
            AppButton(labelText: 'Next', onTap: () {})
          ],
        ),
      ),
    );
  }
}
