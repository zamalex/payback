import 'package:flutter/cupertino.dart';

import '../data/repository/commitments_repo.dart';
import '../data/service_locator.dart';
import '../model/partner_model.dart';

class CommitmentsProvider extends ChangeNotifier{

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


  Future<Map> createCommitment(Map<String, String?> request) async {
    isLoading = true;
    notifyListeners();
    final response = await sl<CommitmentsRepository>().createCommitment(
        request);
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


  Future<Map<String, dynamic>> getInvitationDetails(int id) async {
   isLoading = true;
   notifyListeners();

    final response = await sl<CommitmentsRepository>()
        .getInvitationDetails(id);


   isLoading = false;
   notifyListeners();
    return response;
  }

}