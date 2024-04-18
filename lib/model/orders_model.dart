class Order {
   int? id;
   String? orderId;
   String? productName;
   int? quantity;
   String? vendorName;
   String? productImage;
   String? dateTime;
   double? totalPrice;
   double? cashback;
   String? orderNo;
   String? status;
   String? deliveryMethod;
   String? pickupOffice;
   String? userName;
   String? userPhone;

  Order({
     this.id,
     this.orderId,
     this.productName,
     this.quantity,
     this.vendorName,
     this.productImage,
     this.dateTime,
     this.totalPrice,
     this.cashback,
     this.orderNo,
     this.status,
     this.deliveryMethod,
     this.pickupOffice,
     this.userName,
     this.userPhone,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['order_id'].toString(),
      productName: json['product']['name'],
      quantity: int.parse(json['qty'].toString()),
      vendorName: json['order']['vendor']==null?'----':json['order']['vendor']['store_name'],
      productImage: json['product']==null?'----':json['product']['featured_image'],
      dateTime: json['created_at'],
      totalPrice: double.parse(json['price'].toString()),
      cashback: (json['cashback_value'] != null && (json['cashback_value'] as List).isNotEmpty)? double.parse((json['cashback_value'] as List).first['cashback_value'].toString()) : 0 ,
      orderNo: json['order_id'].toString(),
      status: int.parse(json['order']['status'].toString()).toString(),
      deliveryMethod: json['order']['delivery_method']['name'],
      pickupOffice: 'Office', // You need to extract this information from the data
      userName: (json['order']==null||json['order']['user']==null)?'----':json['order']['user']['name'],
      userPhone: (json['order']==null||json['order']['user']==null)?'----':json['order']['user']['phone'],
    );
  }
}
