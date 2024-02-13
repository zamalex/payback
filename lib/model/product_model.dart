class Product {
  late int id;
  late String? name;
  late String? description;
  late String? quantity;
  late String? price;
  late String? featuredImage;
  late List? gallery;

  late String? categoryId;

  Product({
     required this.id,
     this.name,
     this.description,
     this.quantity,
     this.price,
     this.featuredImage,
    this.gallery,
    this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
      featuredImage: json['featured_image'],
      gallery: json['gallery'],

      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'featured_image': featuredImage,
      'gallery': gallery,

      'category_id': categoryId,
    };
    return data;
  }
}
