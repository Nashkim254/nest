import 'package:nest/models/organization_model.dart';

class UserSearchResult {
  final int id;
  final String firstName;
  final String lastName;
  final String role;
  final String profilePicture;
  final bool isPrivate;
  final double score;

  UserSearchResult({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profilePicture,
    required this.isPrivate,
    required this.score,
  });

  factory UserSearchResult.fromJson(Map<String, dynamic> json) {
    return UserSearchResult(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      role: json['role'] ?? 'user',
      lastName: json['last_name'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      isPrivate: json['is_private'],
      score: (json['score'] != null)
          ? (json['score'] as num).toDouble()
          : 0.0, // Handle null and ensure double type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'profile_picture': profilePicture,
      'is_private': isPrivate,
      'score': score,
    };
  }

  // Add copyWith method for immutability
  UserSearchResult copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? role,
    String? profilePicture,
    bool? isPrivate,
    double? score,
  }) {
    return UserSearchResult(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      profilePicture: profilePicture ?? this.profilePicture,
      isPrivate: isPrivate ?? this.isPrivate,
      score: score ?? this.score,
    );
  }
}

class SearchResultItem {
  final int id;
  final String name;
  final String? subtitle;
  final String? profilePicture;
  final bool isOrganization;
  final UserSearchResult? userResult;
  final Organization? organization;

  SearchResultItem({
    required this.id,
    required this.name,
    this.subtitle,
    this.profilePicture,
    required this.isOrganization,
    this.userResult,
    this.organization,
  });

  factory SearchResultItem.fromUser(UserSearchResult user) {
    return SearchResultItem(
      id: user.id,
      name: '${user.firstName} ${user.lastName}'.trim(),
      subtitle: user.role,
      profilePicture: user.profilePicture,
      isOrganization: false,
      userResult: user,
    );
  }

  factory SearchResultItem.fromOrganization(Organization org) {
    return SearchResultItem(
      id: org.id!,
      name: org.name!,
      subtitle: org.description,
      profilePicture: org.profilePic,
      isOrganization: true,
      organization: org,
    );
  }
}
