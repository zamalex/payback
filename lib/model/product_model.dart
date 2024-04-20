import 'package:get/get.dart';

class Product {
  late int id;
  late String? name;
  late int? vendor_id;
  late String? description;
  late String? quantity;
  late String? price;
  late String? featuredImage;
  late double? cashback;
  late List? gallery;
  int cartQuantity=0;
  bool isSaved =false;

  late String? categoryId;

  Product({
    this.cartQuantity=0,
     required this.id,
     this.name,
    this.cashback=0,
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
      featuredImage: (json['featured_image']==null||json['featured_image']=='')?'https://www.huber-online.com/daisy_website_files/_processed_/8/0/csm_no-image_d5c4ab1322.jpg':json['featured_image'],
      gallery: json['gallery'],
      vendor_id: int.parse(json['vendor_id']==null?'0':json['vendor_id'].toString()),
      cartQuantity: json['cartQuantity']??0,
      cashback: (json['cashback_value'] != null && (json['cashback_value'] as List).isNotEmpty)?(json['cashback_value'] as List).first['cashback_value']==null?0: double.parse((json['cashback_value'] as List).first['cashback_value'].toString()) : 0 ,
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
