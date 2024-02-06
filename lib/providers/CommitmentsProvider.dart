import 'package:flutter/cupertino.dart';

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

}