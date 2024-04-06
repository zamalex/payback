import 'dart:convert';

// Model class to represent the plan data
class Plan {
   int id;
   String planName;
   String price;
   String type;
   bool isSubscribed;


  Plan({
    required this.id,
    required this.planName,
    required this.price,
    required this.type,
    this.isSubscribed = false

  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      planName: json['plan_name'],
      price: json['price'],
      type: json['type'],
    );
  }
}