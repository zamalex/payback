import 'package:flutter/cupertino.dart';
import 'package:payback/model/cashback_dashboard.dart';
import 'package:payback/model/commitment_model.dart';
import 'package:payback/model/orders_model.dart';
import 'package:payback/model/product_model.dart';

import '../data/repository/commitments_repo.dart';
import '../data/service_locator.dart';
import '../model/partner_model.dart';
import '../model/share_details_response.dart';

class CommitmentsProvider extends ChangeNotifier{

  CashBackHistory? cashbackHistory;

  String selectedMonth = '';
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  selectMonth(String s){
    if(selectedMonth==s)
      selectedMonth='';
    else
    selectedMonth = s;

    notifyListeners();
  }

  bool isLoading = false;

  List<Partner> commitmentsCategories = [];
  List<Commitment> commitmentsOfCategory = [];
  List<Order> ordersOfCategory = [];

  Future<Map> getCommitmentsOfCategory(Map<String,dynamic>? params) async {
    isLoading = true;
    notifyListeners();
    final response = await sl<CommitmentsRepository>().getCommitmentsOfCategory(params);

    commitmentsOfCategory = response['data'];
    isLoading = false;
    notifyListeners();


    return response;
  }


  Future<Map> getReceivedProductsOfCategory(Map<String,dynamic>? params) async {
    isLoading = true;
    notifyListeners();
    final response = await sl<CommitmentsRepository>().getReceivedProductsOfCategory(params);

    ordersOfCategory = response['data'];
    isLoading = false;
    notifyListeners();


    return response;
  }

  Future<Map> createCommitment(Map<String, dynamic> request) async {
    isLoading = true;
    notifyListeners();
    final response = await sl<CommitmentsRepository>().createCommitment(
        request);
    isLoading = false;
    notifyListeners();


    return response;
  }

  Future<Map> editCommitment(Map<String, dynamic> request,int id) async {
    isLoading = true;
    notifyListeners();
    final response = await sl<CommitmentsRepository>().editCommitment(
        request,id);
    isLoading = false;
    notifyListeners();


    return response;
  }


  Future<Map> deleteCommitment(int id) async {
    isLoading = true;
    notifyListeners();
    final response = await sl<CommitmentsRepository>().deleteCommitment(
        id);
    isLoading = false;
    notifyListeners();

    return response;
  }


  Future<Map<String, dynamic>> getCommitmentsCategories() async {
    // Implement your loading logic here if needed
    // ...

    final response = await sl<CommitmentsRepository>()
        .getCommitmentsCategories();
    if (response.containsKey('data')) {
      commitmentsCategories = response['data'];
    }

    return response;
  }

  Future<Map<String, dynamic>> acceptRejectInvitation(Map<String,dynamic> body,int id) async {
   isLoading = true;
   notifyListeners();

    final response = await sl<CommitmentsRepository>()
        .acceptRejectInvitation(body,id);


   isLoading = false;
   notifyListeners();
    return response;
  }


  Future<Map<String, dynamic>> sendInvitation(Map<String,dynamic> body) async {
   isLoading = true;
   notifyListeners();

    final response = await sl<CommitmentsRepository>()
        .sendInvitation(body);


   isLoading = false;
   notifyListeners();
    return response;
  }


  ShareDetailsResponse? shareDetailsResponse;


  Future<Map<String, dynamic>> getInvitationDetails(int id) async {
   isLoading = true;
   notifyListeners();

    final response = await sl<CommitmentsRepository>()
        .getInvitationDetails(id);


    shareDetailsResponse = response['data'];


   isLoading = false;
   notifyListeners();
    return response;
  }


  Future<CashBackHistory?> getCashbackHistory(Map<String,dynamic>? params,bool spent) async {
   isLoading = true;
   notifyListeners();

    final response = await sl<CommitmentsRepository>()
        .getCashbackHistory(params);


    cashbackHistory = response;

    if(cashbackHistory!=null){

      if(spent) {
        cashbackHistory!.categories!.removeWhere((element) =>
        element.summary!.fromAllSpent == 0);
      }else{
        cashbackHistory!.categories!.removeWhere((element) => element.summary!.fromAllReceived==0);

      }
    }


   isLoading = false;
   notifyListeners();
    return cashbackHistory;
  }

}