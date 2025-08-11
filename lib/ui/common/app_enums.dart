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

enum EventStatus {
  live(
    'LIVE',
    kcTertiaryColor,
  ),
  upcoming(
    'UPCOMING',
    kcPrimaryColor,
  ),
  ended(
    'ENDED',
    kcRedColor,
  ),
  soldOut(
    'SOLD OUT',
    kcRedColor,
  ),
  cancelled(
    'CANCELLED',
    kcGreyColor,
  );

  const EventStatus(this.label, this.color);
  final String label;
  final Color color;
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
