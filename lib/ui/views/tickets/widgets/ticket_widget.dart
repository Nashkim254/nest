import 'package:flutter/material.dart';
import 'package:nest/models/ticket.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_styles.dart';

import '../../../common/app_strings.dart';
import '../../../common/ui_helpers.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key, required this.ticket});
  final Ticket ticket;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kcDarkGreyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              ticket.eventName,
              style: titleTextMedium.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kcWhiteColor,
              ),
            ),
            subtitle: Text(
              '${ticket.eventDate} ${ticket.eventTime}',
              style: titleTextMedium.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: kcDisableIconColor,
              ),
            ),
            trailing: ticket.qrCode != null
                ? Image.asset(
                    qr,
                    height: 42,
                    width: 42,
                    fit: BoxFit.scaleDown,
                  )
                : null,
          ),
          Container(
            width: 160,
            height: 31,
            decoration: BoxDecoration(
              color: kcGreyButtonColor,
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Center(
              child: Text(
                ticket.ticketType,
                style: titleTextMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kcWhiteColor,
                ),
              ),
            ),
          ),
          verticalSpaceSmall,
          Align(
            child: Container(
              height: 135,
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(ticket.imageUrl!),
                ),
              ),
            ),
          ),
          verticalSpaceMedium,
          AppButton(
            leadingIcon: wallet,
            labelText: 'Save to Wallet',
            onTap: () {},
          ),
          verticalSpaceMedium
        ],
      ),
    );
  }
}
