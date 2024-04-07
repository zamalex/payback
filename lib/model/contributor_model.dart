import 'package:payback/model/commitment_model.dart';

class ContributorModel{
  String? name;
  String? avatar;
  String? amount;
  Commitment? commitment;

  ContributorModel({this.avatar,this.name,this.amount,this.commitment});
}