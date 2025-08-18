class DJ {
  String id;
  String name;
  String time;
  String? web;
  String ig;
  String imageUrl;

  DJ({
    required this.id,
    required this.name,
    required this.time,
    this.web,
    required this.ig,
    required this.imageUrl,
  });

  factory DJ.fromJson(Map<String, dynamic> json) {
    return DJ(
      id: json['id'],
      name: json['name'],
      time: json['time'],
      ig: json['ig'],
      web: json['web'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'ig': ig,
      'web': web,
      'imageUrl': imageUrl,
    };
  }
}
