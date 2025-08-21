// Main Event Card Widget

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/events.dart';
import 'package:nest/utils/utilities.dart';

import '../../../../models/event_data.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_enums.dart';

class EventCardWidget extends StatelessWidget {
  final Event data;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const EventCardWidget({
    Key? key,
    required this.data,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: kcDarkGreyColor,
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              border: Border.all(color: kcContainerBorderColor)),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Menu Row
                    EventCardHeaderWidget(
                      title: data.title,
                      titleStyle: null,
                      onMenuTap: () {},
                    ),

                    const SizedBox(height: 12),

                    // Date and Time
                    EventCardDateTimeWidget(
                      dateTime:
                          '${formatter.format(data.startTime)} - ${formatter.format(data.endTime)}',
                      style: null,
                    ),

                    const SizedBox(height: 12),

                    // Status and Info
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: EventCardStatusWidget(
                  status: EventStatus.live,
                  statusText: data.status,
                  statusTextStyle: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Event Card Header Widget (Title + Menu)
class EventCardHeaderWidget extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final VoidCallback? onMenuTap;

  const EventCardHeaderWidget({
    Key? key,
    required this.title,
    this.titleStyle,
    this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        // // if (onMenuTap != null)
        // GestureDetector(
        //   onTap: onMenuTap,
        //   child: const Icon(
        //     Icons.more_vert,
        //     color: Colors.white,
        //     size: 20,
        //   ),
        // ),
      ],
    );
  }
}

// Event Card Date Time Widget
class EventCardDateTimeWidget extends StatelessWidget {
  final String dateTime;
  final TextStyle? style;

  const EventCardDateTimeWidget({
    Key? key,
    required this.dateTime,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime,
      style: style ??
          const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
    );
  }
}

// Event Card Status Widget (Badge + Text)
class EventCardStatusWidget extends StatelessWidget {
  final EventStatus status;
  final String statusText;
  final TextStyle? statusTextStyle;

  const EventCardStatusWidget({
    Key? key,
    required this.status,
    required this.statusText,
    this.statusTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status.color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Factory Methods for Common Use Cases
// class EventCardFactory {
//   // Live Event Card
//   static EventCardWidget live({
//     required String title,
//     required String dateTime,
//     required int soldTickets,
//     required int totalTickets,
//     VoidCallback? onTap,
//     VoidCallback? onMenuTap,
//   }) {
//     return EventCardWidget(
//       data: EventCardData(
//         title: title,
//         dateTime: dateTime,
//         status: EventStatus.live,
//         statusText: 'Tickets Sold: $soldTickets/$totalTickets',
//         onTap: onTap,
//         onMenuTap: onMenuTap,
//       ),
//     );
//   }
//
//   // Upcoming Event Card
//   static EventCardWidget upcoming({
//     required String title,
//     required String dateTime,
//     required int availableTickets,
//     required int totalTickets,
//     VoidCallback? onTap,
//     VoidCallback? onMenuTap,
//   }) {
//     return EventCardWidget(
//       data: EventCardData(
//         title: title,
//         dateTime: dateTime,
//         status: EventStatus.upcoming,
//         statusText: 'Tickets Available: $availableTickets/$totalTickets',
//         onTap: onTap,
//         onMenuTap: onMenuTap,
//       ),
//     );
//   }
//
//   // Sold Out Event Card
//   static EventCardWidget soldOut({
//     required String title,
//     required String dateTime,
//     required int totalTickets,
//     VoidCallback? onTap,
//     VoidCallback? onMenuTap,
//   }) {
//     return EventCardWidget(
//       data: EventCardData(
//         title: title,
//         dateTime: dateTime,
//         status: EventStatus.soldOut,
//         statusText: 'All $totalTickets tickets sold',
//         onTap: onTap,
//         onMenuTap: onMenuTap,
//       ),
//     );
//   }
//
//   // Ended Event Card
//   static EventCardWidget ended({
//     required String title,
//     required String dateTime,
//     required int attendees,
//     VoidCallback? onTap,
//     VoidCallback? onMenuTap,
//   }) {
//     return EventCardWidget(
//       data: EventCardData(
//         title: title,
//         dateTime: dateTime,
//         status: EventStatus.ended,
//         statusText: '$attendees attendees',
//         onTap: onTap,
//         onMenuTap: onMenuTap,
//       ),
//     );
//   }
//
//   // Custom Event Card
//   static EventCardWidget custom({
//     required String title,
//     required String dateTime,
//     required EventStatus status,
//     required String statusText,
//     VoidCallback? onTap,
//     VoidCallback? onMenuTap,
//     Color? backgroundColor,
//     TextStyle? titleStyle,
//     TextStyle? dateTimeStyle,
//     TextStyle? statusTextStyle,
//   }) {
//     return EventCardWidget(
//       data: EventCardData(
//         title: title,
//         dateTime: dateTime,
//         status: status,
//         statusText: statusText,
//         onTap: onTap,
//         onMenuTap: onMenuTap,
//         backgroundColor: backgroundColor,
//         titleStyle: titleStyle,
//         dateTimeStyle: dateTimeStyle,
//         statusTextStyle: statusTextStyle,
//       ),
//     );
//   }
// }
