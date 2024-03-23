class Commitment {
  late int? id=0;
  late String? name;
  late String? image;
  late int? partnerId;
  late String? categoryId;
  late String? categoryName;
  late String? paymentTarget;
  late String? cashbackToCommitment;
  late String? dueDate;
  late String? paid;
  late String? type;
  late String? notify;
  late String? createdAt;
  late String? updatedAt;

  Commitment({
    required this.id,
     this.name,
     this.partnerId,
     this.categoryId,
    this.categoryName,
     this.paymentTarget,
     this.cashbackToCommitment,
     this.dueDate,
     this.type,
     this.image,
     this.notify,
     this.createdAt,
     this.updatedAt, this.paid,
  });

  factory Commitment.fromJson(Map<String, dynamic> json) {
    return Commitment(
      id: json['id']??0,
      name: json['name'],
      image: json['partner']['image'],
     // partnerId: json['partner_id'],
      partnerId: json['partner']['id'],
      categoryId: json['category_id'],
      categoryName: json['partner']['name'],
      paymentTarget: json['payment_target'],
      cashbackToCommitment: json['cashback_to_commitment'],
      dueDate: json['due_date'],
      type: json['type'],
      paid: json['paid']??'0',
      notify: json['notify'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'partner_id': partnerId,
      'image': image,
      'category_id': categoryId,
      'payment_target': paymentTarget,
      'cashback_to_commitment': cashbackToCommitment,
      'due_date': dueDate,
      'type': type,
      'notify': notify,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
    return data;
  }
}
