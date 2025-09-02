class AddTeamMemberInput {
  final int userId;
  final String role;
  final List<String> permissions;

  AddTeamMemberInput({
    required this.userId,
    required this.role,
    required this.permissions,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'role': role,
      'permissions': permissions,
    };
  }

  factory AddTeamMemberInput.fromJson(Map<String, dynamic> json) {
    return AddTeamMemberInput(
      userId: json['user_id'] as int,
      role: json['role'] as String,
      permissions: List<String>.from(json['permissions'] as List),
    );
  }

  AddTeamMemberInput copyWith({
    int? userId,
    String? role,
    List<String>? permissions,
  }) {
    return AddTeamMemberInput(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
    );
  }
}
