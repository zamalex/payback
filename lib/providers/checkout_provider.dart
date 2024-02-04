
import 'package:flutter/cupertino.dart';
import 'package:payback/screens/checkout_object.dart';

class CheckoutProvider extends ChangeNotifier{

  List<CheckoutObject> checkouts = [
    CheckoutObject(selectedDelivery: 0, selectedPickup: 0),
    CheckoutObject(selectedDelivery: 0, selectedPickup: 0),

  ];


  updateDelivery(int orderIndex,int selectedIndex){

    checkouts[orderIndex].selectedDelivery=selectedIndex;
    notifyListeners();
  }


  updatePickup(int orderIndex,int selectedIndex){

    checkouts[orderIndex].selectedPickup=selectedIndex;
    notifyListeners();
  }

}