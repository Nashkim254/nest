class Organization {
  int? id;
  String? name;
  String? description;
  String? profilePic;
  String? banner;
  List<String>? genres;
  String? bio;
  List<String>? countries;
  bool? isVerified;

  // Contact Information
  String? whatsApp;
  String? phoneNumber;
  String? email;

  // Social Media Links
  String? instagram;
  String? twitter;
  String? linkedIn;
  String? facebook;
  String? website;

  // Payment Processing
  String? stripeConnectAccountId;
  double? serviceFee;

  // Team Members
  List<TeamMember>? teamMembers;

  Organization({
    this.id,
    this.name,
    this.description,
    this.profilePic,
    this.banner,
    this.genres,
    this.bio,
    this.countries,
    this.isVerified,
    this.whatsApp,
    this.phoneNumber,
    this.email,
    this.instagram,
    this.twitter,
    this.linkedIn,
    this.facebook,
    this.website,
    this.stripeConnectAccountId,
    this.serviceFee,
    this.teamMembers,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['ID'],
      name: json['name'],
      description: json['description'],
      profilePic: json['profile_pic'],
      banner: json['banner'],
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      bio: json['bio'],
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isVerified: json['is_verified'],
      whatsApp: json['whatsapp'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      linkedIn: json['linkedin'],
      facebook: json['facebook'],
      website: json['website'],
      stripeConnectAccountId: json['stripe_connect_account_id'],
      serviceFee: (json['service_fee'] as num?)?.toDouble(),
      teamMembers: (json['team_members'] as List<dynamic>?)
          ?.map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "name": name,
      "description": description,
      "profile_pic": profilePic,
      "banner": banner,
      "genres": genres,
      "bio": bio,
      "countries": countries,
      "is_verified": isVerified,
      "whatsapp": whatsApp,
      "phone_number": phoneNumber,
      "email": email,
      "instagram": instagram,
      "twitter": twitter,
      "linkedin": linkedIn,
      "facebook": facebook,
      "website": website,
      "stripe_connect_account_id": stripeConnectAccountId,
      "service_fee": serviceFee,
      "team_members": teamMembers?.map((e) => e.toJson()).toList(),
    };
  }
}

class TeamMember {
  int? id;
  int? organizationId;
  String? name;
  String? role;
  final String? email;
  final String? avatarUrl;
  final String? status;

  TeamMember({
    this.id,
    this.organizationId,
    this.name,
    this.role,
    this.email,
    this.avatarUrl,
    this.status,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      id: json['id'],
      organizationId: json['organization_id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "organization_id": organizationId,
      "name": name,
      "role": role,
      "avatar_url": avatarUrl,
      "email": email,
      "status": status,
    };
  }
}
