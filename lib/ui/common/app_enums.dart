import 'dart:ui';

import 'package:nest/ui/common/app_colors.dart';

enum DiscoverableType {
  all,
  people,
  organizations,
}

enum SettingsType {
  everyone,
  friends,
  none,
}

enum MessageType {
  sent,
  received,
}

enum ImageSourceType { camera, gallery, multiple }

enum ContentType {
  fyp,
  upcoming,
  following,
}

enum FinderType {
  all,
  people,
  organizations,
}

enum ReportReason {
  spam('Spam'),
  nudityOrSexualActivity('Nudity or sexual activity'),
  hateSpeechOrSymbols('Hate speech or symbols'),
  violenceOrDangerousOrganizations('Violence or dangerous organizations'),
  bullyingOrHarassment('Bullying or harassment'),
  intellectualPropertyViolation('Intellectual property violation'),
  scamOrFraud('Scam or fraud'),
  falseInformation('False information');

  const ReportReason(this.displayName);
  final String displayName;
}

enum HostingSelector {
  events('Events'),
  analytics('Analytics'),
  quickActions('Quick Actions');

  const HostingSelector(this.displayName);
  final String displayName;
}

enum EventMode {
  rsvp('RSVP Only'),
  paid('Paid Tickets');

  const EventMode(this.label);
  final String label;
}

enum WebSocketConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
}

enum ConfirmationMethodType { sms, email }

enum PaymentMethodType {
  applePay(false),
  googlePay(false),
  card(true);

  const PaymentMethodType(this.isEnabled);
  final bool isEnabled;
}

enum FileType { image, video, audio, document, other }

enum EventStatus {
  live,
  draft,
  past,
  cancelled;

  Color get color {
    switch (this) {
      case EventStatus.live:
        return kcTertiaryColor;
      case EventStatus.draft:
        return kcPrimaryColor;
      case EventStatus.past:
        return kcGrey3Color;
      case EventStatus.cancelled:
        return kcSecondaryColor;
    }
  }

  String get displayName {
    return name.toUpperCase();
  }
}

enum EventFilter {
  all,
  upcoming,
  past;

  String get displayName {
    switch (this) {
      case EventFilter.all:
        return 'All';
      case EventFilter.upcoming:
        return 'Upcoming';
      case EventFilter.past:
        return 'Past';
    }
  }
}
enum Environment { development, staging, production }
