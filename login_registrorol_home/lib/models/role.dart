class Role {
  final int? id;
  final String name;
  final String description;

  Role({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}