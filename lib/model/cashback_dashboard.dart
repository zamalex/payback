class CashBackHistory {
  List<HistoryCategory>? categories;

  CashBackHistory({this.categories});

  CashBackHistory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <HistoryCategory>[];
      json['data'].forEach((v) {
        categories!.add(new HistoryCategory.fromJson(v));
      });
    }
  }


}

class HistoryCategory {
  String? category;
  String? categoryId;
  Summary? summary;



  HistoryCategory({this.category, this.categoryId, this.summary});

  HistoryCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryId = json['category_id'].toString();
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
  }

}

class Summary {
  double? received;
  double? spent;
  double? withdrawUnsignedBalance;
  double? depositUnsignedBalance;
  double? withdrawAssignedBalance;
  double? depositAssignedBalance;
  double fromAllSpent=0;
  double fromAllReceived=0;

  Summary(
      {this.received=0,
        this.spent=0,
        this.withdrawUnsignedBalance=0,
        this.depositUnsignedBalance=0,
        this.fromAllReceived=0,
        this.withdrawAssignedBalance=0,
        this.depositAssignedBalance=0});

  Summary.fromJson(Map<String, dynamic> json) {
    received = double.parse(json['deposit'].toString());
    spent = double.parse(json['withdraw'].toString());
    withdrawUnsignedBalance = double.parse(json['withdraw_unsigned_balance'].toString());
    depositUnsignedBalance = double.parse(json['deposit_unsigned_balance'].toString());
    withdrawAssignedBalance = double.parse(json['withdraw_assigned_balance'].toString());
    depositAssignedBalance = double.parse(json['deposit_assigned_balance'].toString());

  }

   calculateFromAll(List<HistoryCategory> cats){

      double all = 0;
      cats.forEach((element) {
        all+= element.summary!.spent!;
      });
      fromAllSpent = all==0?0:(this.spent!/all)*100;


       all = 0;
      cats.forEach((element) {
        all+= element.summary!.received!;
      });

      fromAllReceived =all==0?0: (this.received!/all)*100;


      fromAllSpent=double.parse(fromAllSpent.toStringAsFixed(2));
      fromAllReceived=double.parse(fromAllReceived.toStringAsFixed(2));
      /*if(fromAllSpent==0){
        fromAllSpent=10;
      }

      if(fromAllReceived==0){
        fromAllReceived=10;
      }*/




  }


}