class Partner {
  late int id;
  late String? name;
  late String? description;
  late String? image;

  Partner({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
    return data;
  }
}
