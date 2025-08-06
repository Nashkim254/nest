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
