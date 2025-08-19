class Profile {
  final int id;
  final String firstName;
  final String lastName;
  final String displayName;
  final String profilePicture;
  final String bio;
  final List<String> interests;
  final double longitude;
  final double latitude;
  final String location;
  final bool isPrivate;
  final bool isVerified;
  final String role;
  final int followersCount;
  final int followingCount;
  final DateTime createdAt;
  final DateTime lastActive;
  final String? twitter;
  final String? instagram;
  final String? facebook;
  final String? linkedIn;
  final String? youTube;
  final String? soundCloud;
  final String? spotify;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.profilePicture,
    required this.bio,
    required this.interests,
    required this.longitude,
    required this.latitude,
    required this.location,
    required this.isPrivate,
    required this.isVerified,
    required this.role,
    required this.followersCount,
    required this.followingCount,
    required this.createdAt,
    required this.lastActive,
    this.twitter,
    this.instagram,
    this.facebook,
    this.linkedIn,
    this.youTube,
    this.soundCloud,
    this.spotify,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      displayName: json['display_name'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      bio: json['bio'] ?? '',
      interests: (json['interests'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] ?? '',
      isPrivate: json['is_private'] ?? false,
      isVerified: json['is_verified'] ?? false,
      role: json['role'] ?? '',
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      lastActive: DateTime.tryParse(json['last_active'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      twitter: json["twitter"],
      instagram: json["instagram"],
      facebook: json["facebook"],
      linkedIn: json["linkedin"],
      youTube: json["youtube"],
      soundCloud: json["soundcloud"],
      spotify: json["spotify"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'display_name': displayName,
      'profile_picture': profilePicture,
      'bio': bio,
      'interests': interests,
      'longitude': longitude,
      'latitude': latitude,
      'location': location,
      'is_private': isPrivate,
      'is_verified': isVerified,
      'role': role,
      'followers_count': followersCount,
      'following_count': followingCount,
      'created_at': createdAt.toUtc().toIso8601String(),
      'last_active': lastActive.toUtc().toIso8601String(),
      if (twitter != null) "twitter": twitter,
      if (instagram != null) "instagram": instagram,
      if (facebook != null) "facebook": facebook,
      if (linkedIn != null) "linkedin": linkedIn,
      if (youTube != null) "youtube": youTube,
      if (soundCloud != null) "soundcloud": soundCloud,
      if (spotify != null) "spotify": spotify,
    };
  }
}
