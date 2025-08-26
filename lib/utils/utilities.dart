import 'package:intl/intl.dart';
import 'package:nest/ui/common/app_enums.dart';

final formatter = DateFormat('E, MMM dd, yyyy hh:mm a');

class Utilities {
  static String statusText(EventStatus status) {
    switch (status) {
      case EventStatus.live:
        return 'Live';
      case EventStatus.draft:
        return 'Draft';
      case EventStatus.past:
        return 'Past';
      case EventStatus.cancelled:
        return 'Cancelled';
    }
  }

  static EventStatus getEventStatus(String status) {
    switch (status.toLowerCase()) {
      case 'live':
        return EventStatus.live;
      case 'draft':
        return EventStatus.draft;
      case 'past':
        return EventStatus.past;
      case 'cancelled':
        return EventStatus.cancelled;
      default:
        return EventStatus.draft; // Default to draft if unknown
    }
  }
}
