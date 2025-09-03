import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/models/ticket.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/utils/utilities.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
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
            padding: const EdgeInsets.all(12), // Reduced padding
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
                // Image - Further optimized
                Flexible(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                          image: AssetImage(ev1), fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // Title - Flexible to take available space
                Flexible(
                  flex: 2,
                  child: Text(
                    ticket.eventTitle!,
                    style: titleTextMedium.copyWith(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Date and QR code row - Fixed height
                SizedBox(
                  height: 24,
                  child: Row(
                    children: [
                      // Date takes available space
                      Expanded(
                        child: Text(
                          formatter.format(ticket.eventDate!),
                          style: titleTextMedium.copyWith(
                            color: kcGreyColor,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      // QR Code - Fixed size
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: ticket.qrCode != null && ticket.qrCode.isNotEmpty
                            ? Container(
                                height: 42,
                                width: 42,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: PrettyQrView.data(
                                  data: ticket.qrCode,
                                  decoration: const PrettyQrDecoration(
                                    background: Colors.white,
                                    shape: PrettyQrSmoothSymbol(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            : SvgPicture.asset(qrcode),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
