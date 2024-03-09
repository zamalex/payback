class Commitment {
  late int id;
  late String? name;
  late String? image;
  late String? partnerId;
  late String? categoryId;
  late String? paymentTarget;
  late String? cashbackToCommitment;
  late String? dueDate;
  late String? type;
  late String? notify;
  late String? createdAt;
  late String? updatedAt;

  Commitment({
    required this.id,
     this.name,
     this.partnerId,
     this.categoryId,
     this.paymentTarget,
     this.cashbackToCommitment,
     this.dueDate,
     this.type,
     this.image,
     this.notify,
     this.createdAt,
     this.updatedAt,
  });

  factory Commitment.fromJson(Map<String, dynamic> json) {
    return Commitment(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      partnerId: json['partner_id'],
      categoryId: json['category_id'],
      paymentTarget: json['payment_target'],
      cashbackToCommitment: json['cashback_to_commitment'],
      dueDate: json['due_date'],
      type: json['type'],
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
