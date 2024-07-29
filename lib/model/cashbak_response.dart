class CashbackModel {
  final double deposit;
  final double withdraw;
  final double withdrawUnsignedBalance;
  final double depositUnsignedBalance;
  final double withdrawAssignedBalance;
  final double depositAssignedBalance;

  CashbackModel({
    required this.deposit,
    required this.withdraw,
    required this.withdrawUnsignedBalance,
    required this.depositUnsignedBalance,
    required this.withdrawAssignedBalance,
    required this.depositAssignedBalance,
  });

  factory CashbackModel.fromJson(Map<String, dynamic> json) {
    return CashbackModel(
      deposit: double.parse(json['deposit'].toString()),
      withdraw: double.parse(json['withdraw'].toString()),
      withdrawUnsignedBalance: double.parse(json['withdraw_unsigned_balance'].toString()),
      depositUnsignedBalance: double.parse(json['deposit_unsigned_balance'].toString()),
      withdrawAssignedBalance: double.parse(json['withdraw_assigned_balance'].toString()),
      depositAssignedBalance: double.parse(json['deposit_assigned_balance'].toString()),
      
    );
  }
}