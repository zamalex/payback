class Transaction {
  String amount;
  String status;
  Reference? reference;

  Transaction({
    required this.amount,
    required this.status,
    required this.reference,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    amount: json["amount"],
    status: json["status"],
    reference:json["reference"] is List?null: Reference.fromJson(json["reference"]),
  );
}

class Reference {
  String name;
  String? category;
  String type;
  String createdAt;

  Reference({
    required this.name,
    required this.category,
    required this.type,
    required this.createdAt,
  });

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
    name: json["name"],
    category: json["category"]??'',
    type: json["type"],
    createdAt: json["created_at"],
  );
}