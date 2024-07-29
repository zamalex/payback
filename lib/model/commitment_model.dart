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
  late String? user_id;

  late double? completed_percentage;

  late bool? completed;

  late String? sadad_num;

  double amount;

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
    this.amount=0,
     this.createdAt,
    this.completed_percentage,
    this.completed,
     this.user_id,
    this.sadad_num,
     this.updatedAt, this.paid,
  });

  factory Commitment.fromJson(Map<String, dynamic> json) {
    return Commitment(
      id: json['id']??0,
      name: json['name'],
      image:  json['partner']==null?'':json['partner']['image'],
     // partnerId: json['partner_id'],
      partnerId:json['partner']==null?null: json['partner']['id'],
      categoryId: json['category_id'],
      categoryName:json['partner']==null?'': json['partner']['name'],
      paymentTarget: json['payment_target'],
      cashbackToCommitment: json['cashback_to_commitment'],
      dueDate: json['due_date'],
      type: json['type'],
      paid: json['paid']??'0',
      notify: json['notify'],
      sadad_num: json['partners_requirements'] != null &&
          (json['partners_requirements'] as List).isNotEmpty &&
          (json['partners_requirements'] as List).firstWhere(
                  (item) => item['key'] == 'sadad_num',
              orElse: () => null
          ) != null
          ? (json['partners_requirements'] as List)
          .firstWhere((item) => item['key'] == 'sadad_num')['value']
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user_id: json['user_id'],
      completed: json['completed']??false,
      completed_percentage: json['completed_percentage'] == null?0:double.parse(json['completed_percentage'].toString()),
    );
  }

  String? getSadad(Map<String, dynamic> json){
    String? sadad;

    //partners_requirements: [{display_name: Sadad Num., key: sadad_num, value: 123463}]

    if(json['partners_requirements']!=null){
      if(((json['partners_requirements'])as List).isNotEmpty){
        if(((json['partners_requirements'])as List).first['key']=='sadad_num'){
            sadad = ((json['partners_requirements'])as List).first['value'];
        }
      }
    }

    return sadad;
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
      'completed_percentage': completed_percentage,
      'completed': completed,
    };
    return data;
  }
}
