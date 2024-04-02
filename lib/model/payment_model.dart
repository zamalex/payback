class PaymentSetting {
  String? paymentGateway;
  String? customPaymentDescriptions;
  String? paymentPageLogo;

  PaymentSetting({
    this.paymentGateway,
    this.customPaymentDescriptions,
    this.paymentPageLogo,
  });

  factory PaymentSetting.fromJson(Map<String, dynamic> json) {
    return PaymentSetting(
      paymentGateway: json['payment_gateway'],
      customPaymentDescriptions: json['custom_payment_descriptions'],
      paymentPageLogo: json['payment_page_logo'],
    );
  }
}
