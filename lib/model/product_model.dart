import 'package:get/get.dart';

class Product {
  late int id;
  late String? name;
  late int? vendor_id;
  late int? quantity_to;
  late int? quantity_from;
  late String? description;
  late String? quantity;
  late String? price;
  late String? featuredImage;
  late double? cashback;
  late double? cashback2;
  late List? gallery;
  int cartQuantity=0;
  bool isSaved =false;

  late String? categoryId;

  Product({
    this.cartQuantity=0,
     required this.id,
     this.name,
    this.cashback,
    this.cashback2,
     this.description,
     this.vendor_id,
     this.quantity,
     this.price,
     this.featuredImage,
    this.quantity_from,
    this.quantity_to,
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
      cashback:json['cashback']!=null?double.parse(json['cashback'].toString()): (json['cashback_value'] != null &&json['cashback_value'] is List&& (json['cashback_value'] as List).isNotEmpty)?(json['cashback_value'] as List).first['cashback_value']==null?0: double.parse((json['cashback_value'] as List).first['user_cashback_value'].toString()) : 0 ,
      cashback2:json['cashback']==null?0:double.parse(json['cashback'].toString()??'0'),
      quantity_from:json['quantity_from'] != null?json['quantity_from']: (json['cashback_value'] != null && (json['cashback_value'] as List).isNotEmpty)?(json['cashback_value'] as List).first['quantity_from']==null?0: int.parse((json['cashback_value'] as List).first['quantity_from'].toString()) : 0 ,
      quantity_to:json['quantity_to'] != null?json['quantity_to']: (json['cashback_value'] != null && (json['cashback_value'] as List).isNotEmpty)?(json['cashback_value'] as List).first['quantity_to']==null?0: int.parse((json['cashback_value'] as List).first['quantity_to'].toString()) : 0 ,
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
      'cashback': cashback,
      'quantity_from': quantity_from,
      'quantity_to': quantity_to,
      'categoryId': categoryId,
      'category_id': categoryId,
      'cartQuantity': cartQuantity,
    };
    return data;
  }
}
