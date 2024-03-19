class Order {
  final int? id;
  final String? userId;
  final String? vendorId;
  final String? paymentSettingId;
  final String? deliveryMethodId;
  final String? description;
  final String? amount;
  final String? taxAmount;
  final String? discountAmount;
  final String? shippingAmount;
  final String? subTotal;
  final String? couponCode;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Order({
    this.id,
    this.userId,
    this.vendorId,
    this.paymentSettingId,
    this.deliveryMethodId,
    this.description,
    this.amount,
    this.taxAmount,
    this.discountAmount,
    this.shippingAmount,
    this.subTotal,
    this.couponCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      vendorId: json['vendor_id'],
      paymentSettingId: json['payment_setting_id'],
      deliveryMethodId: json['delivery_method_id'],
      description: json['description'],
      amount: json['amount'],
      taxAmount: json['tax_amount'],
      discountAmount: json['discount_amount'],
      shippingAmount: json['shipping_amount'],
      subTotal: json['sub_total'],
      couponCode: json['coupon_code'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

