class People{
  final String name;
  final String imageUrl;
  final String role;

  People({
    required this.name,
    required this.imageUrl,
    required this.role,
  });

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'role': role,
    };
  }
}