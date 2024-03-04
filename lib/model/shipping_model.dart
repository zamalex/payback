class ShippingMethod {
  late String? name;
  late String? description;
  late String? logo;

  ShippingMethod({
    required this.name,
    required this.description,
    required this.logo,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'logo': logo,
    };
    return data;
  }
}
