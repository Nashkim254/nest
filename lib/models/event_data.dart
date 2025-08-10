import 'package:flutter/material.dart';

import '../ui/common/app_enums.dart';

class EventCardData {
  final String title;
  final String dateTime;
  final EventStatus status;
  final String statusText; // e.g., "Tickets Sold: 150/200"
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? dateTimeStyle;
  final TextStyle? statusTextStyle;
  final String? imageUrl;
  final String? location;

  EventCardData({
    required this.title,
    required this.dateTime,
    required this.status,
    required this.statusText,
    this.onTap,
    this.onMenuTap,
    this.backgroundColor,
    this.titleStyle,
    this.dateTimeStyle,
    this.statusTextStyle,
    this.imageUrl,
    this.location,
  });
}
