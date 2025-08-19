class UpdateProfileInput {
  final String firstName;
  final String lastName;
  final String displayName;
  final String profilePicture;
  final String bio;
  final String location;
  final List<String> interests;
  final PrivacySettings? privacySettings;

  UpdateProfileInput({
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.profilePicture,
    required this.bio,
    required this.location,
    required this.interests,
    this.privacySettings,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "display_name": displayName,
      "profile_picture": profilePicture,
      "bio": bio,
      "location": location,
      "interests": interests,
      if (privacySettings != null)
        "privacy_settings": privacySettings!.toJson(),
    };
  }
}

class PrivacySettings {
  final bool isPrivate;
  final bool showOnGuestList;
  final bool showEvents;

  PrivacySettings({
    required this.isPrivate,
    required this.showOnGuestList,
    required this.showEvents,
  });

  Map<String, dynamic> toJson() {
    return {
      "is_private": isPrivate,
      "show_on_guest_list": showOnGuestList,
      "show_events": showEvents,
    };
  }

  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      isPrivate: json["is_private"] ?? false,
      showOnGuestList: json["show_on_guest_list"] ?? false,
      showEvents: json["show_events"] ?? false,
    );
  }
}
