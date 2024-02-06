import 'package:flutter/cupertino.dart';

class CommitmentsProvider extends ChangeNotifier{

  String selectedMonth = '';

  selectMonth(String s){
    if(selectedMonth==s)
      selectedMonth='';
    else
    selectedMonth = s;

    notifyListeners();
  }

}