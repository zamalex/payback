class Product {
  late int id;
  late String? name;
  late int? vendor_id;
  late String? description;
  late String? quantity;
  late String? price;
  late String? featuredImage;
  late List? gallery;
  int cartQuantity=0;
  bool isSaved =false;

  late String? categoryId;

  Product({
    this.cartQuantity=0,
     required this.id,
     this.name,
     this.description,
     this.vendor_id,
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
      vendor_id: int.parse(json['vendor_id']??'0'),
      cartQuantity: json['cartQuantity']??0,

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
      'vendor_id': vendor_id,
      'gallery': gallery,
      'categoryId': categoryId,
      'category_id': categoryId,
      'cartQuantity': cartQuantity,
    };
    return data;
  }
}
