class Partner {
  late int id;
  late String? name;
  late String? description;
  late String? image;
  bool isChecked = false;
  bool isSaved = false;

  Partner({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      name: json['name']??json['store_name'],
      description: json['description'],
      image: json['image']??json['store_photo']??json['store_banner']??'https://www.huber-online.com/daisy_website_files/_processed_/8/0/csm_no-image_d5c4ab1322.jpg',
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
