
import 'package:flutter/cupertino.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/model/product_model.dart';
import 'package:payback/screens/checkout_object.dart';

import '../data/service_locator.dart';

class CheckoutProvider extends ChangeNotifier{

  List<CheckoutObject> checkouts = [
    CheckoutObject(selectedDelivery: 0, selectedPickup: 0,),
    CheckoutObject(selectedDelivery: 0, selectedPickup: 0),

  ];

  List<Product> cart = [];

  readCart()async{
    cart = await sl<PreferenceUtils>().readCart();
    notifyListeners();
  }

  addToCart(Product product) async{
    cart = await sl<PreferenceUtils>().addToCart(product);
    notifyListeners();
  }

  removeFromCart(Product product,{bool remove=false})async{
    cart = await sl<PreferenceUtils>().removeFromCart(product,remove: remove);
    notifyListeners();
  }


  updateDelivery(int orderIndex,int selectedIndex){

    checkouts[orderIndex].selectedDelivery=selectedIndex;
    notifyListeners();
  }


  updatePickup(int orderIndex,int selectedIndex){

    checkouts[orderIndex].selectedPickup=selectedIndex;
    notifyListeners();
  }

}