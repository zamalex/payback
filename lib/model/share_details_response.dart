class ShareDetailsResponse {
  ShareDetails? data;

  ShareDetailsResponse({this.data});

  ShareDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ShareDetails.fromJson(json['data']) : null;
  }


}

class ShareDetails {
  int? id;
  ShareUser? user;
  ShareCommit? commitment;
  String? amount;
  String? status;

  ShareDetails({this.id, this.user, this.commitment, this.amount, this.status});

  ShareDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new ShareUser.fromJson(json['user']) : null;
    commitment = json['commitment'] != null
        ? new ShareCommit.fromJson(json['commitment'])
        : null;
    amount =json['amount'];
    status = json['status'];
  }


}

class ShareUser {
  int? id;
  String? name;
  String? email;

  String? avatarUrl;
  String? phone;

  ShareUser(
      {this.id,
        this.name,
        this.email,
        this.avatarUrl,
        this.phone,
});

  ShareUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatarUrl = json['avatar_url'];
    phone = json['phone'];
  }

}

class ShareCommit {
  int? id;
  String? name;
  String? partnerId;
  String? categoryId;
  String? paymentTarget;
  String? cashbackToCommitment;
  String? dueDate;
  String? userId;
  String? image;

  ShareCommit(
      {this.id,
        this.name,
        this.partnerId,
        this.categoryId,
        this.paymentTarget,
        this.cashbackToCommitment,
        this.dueDate,
        this.userId,
        this.image
 });

  ShareCommit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    partnerId = json['partner_id'];
    categoryId = json['category_id'];
    paymentTarget = json['payment_target'];
    cashbackToCommitment = json['cashback_to_commitment'];
    dueDate = json['due_date'];
    userId = json['user_id'];
    image=  json['partner']==null?'':json['partner']['image'];

  }


}