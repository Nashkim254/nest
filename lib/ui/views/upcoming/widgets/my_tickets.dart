import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/models/ticket.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../upcoming_viewmodel.dart';

class MyTicketWidget extends StatelessWidget {
  const MyTicketWidget({Key? key, required this.ticket}) : super(key: key);
  final Ticket ticket;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpcomingViewModel>.reactive(
      viewModelBuilder: () => UpcomingViewModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTapDown: (_) => model.onPressDown(),
          onTapUp: (_) => model.onPressUp(),
          onTapCancel: () => model.onPressUp(),
          onTap: model.onTap,
          child: Container(
            width: 226,
            height: 210,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kcDarkGreyColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: kcContainerBorderColor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 95,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                        image: AssetImage(ev1), fit: BoxFit.cover),
                  ),
                ),
                verticalSpaceTiny,
                Text(ticket.eventName, style: titleTextMedium),
                verticalSpaceTiny,
                // Date and time
                Text(
                  '${ticket.eventDate} ${ticket.eventTime}',
                  style: titleTextMedium.copyWith(
                    color: kcGreyColor,
                    fontSize: 13,
                  ),
                ),
                verticalSpaceTiny,
                // Bottom row with countdown and status
                SvgPicture.asset(qrcode),
              ],
            ),
          ),
        );
      },
    );
  }
}
