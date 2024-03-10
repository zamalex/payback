
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/data/repository/checkout_repo.dart';
import 'package:payback/model/product_model.dart';
import 'package:payback/model/shipping_model.dart';
import 'package:payback/screens/checkout_object.dart';

import '../data/service_locator.dart';

class CheckoutProvider extends ChangeNotifier{

  List<CheckoutObject> checkouts = [


  ];
  Map<int, List<Product>> groupProductsByVendor() {
    Map<int, List<Product>> groupedMap = {};

    for (Product product in cart) {
      if (!groupedMap.containsKey(product.vendor_id)) {
        groupedMap[product.vendor_id!] = [];
      }
      groupedMap[product.vendor_id]!.add(product);
    }

    checkouts.clear();
    groupedMap.forEach((key, value) {
      checkouts.add( CheckoutObject(selectedDelivery: 0, selectedPickup: 0,vendor: key,products: value));
    });
    notifyListeners();
    return groupedMap;
  }

  bool isLoading = false;
  List<Product> cart = [];
  List<ShippingMethod> shippings = [];

  readCart(List<Product>pros)async{
    cart = await sl<PreferenceUtils>().readCart();
    syncCartProducts(pros);

    groupProductsByVendor();
  }

  addToCart(Product product) async{
    cart = await sl<PreferenceUtils>().addToCart(product);
    groupProductsByVendor();
  }

  removeFromCart(Product product,{bool remove=false})async{
    cart = await sl<PreferenceUtils>().removeFromCart(product,remove: remove);
    groupProductsByVendor();
  }


  updateDelivery(int orderIndex,int selectedIndex){

    checkouts[orderIndex].selectedDelivery=selectedIndex;
    notifyListeners();
  }


  updatePickup(int orderIndex,int selectedIndex){

    checkouts[orderIndex].selectedPickup=selectedIndex;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getShippingMethods() async {

    final response = await sl<CheckoutRepository>().getShippingMethods();
    if (response.containsKey('data')) {
      shippings = response['data'];
    }



    notifyListeners();
    return response;
  }

  syncCartProducts(List<Product> prods){
    cart.forEach((c) {
      Product? p = prods.firstWhereOrNull((element) => c.id==element.id,);

      if(p!=null){
        c=p..cartQuantity=c.cartQuantity;
      }
      else{
        cart.removeWhere((element) => element.id==c.id);
      }
    });

  }


 Future<Map> createOrder(Map<String,dynamic> body)async{

    isLoading = true;
    notifyListeners();


    final response = await sl<CheckoutRepository>().createOrder(body);


    isLoading = false;
    notifyListeners();

    return response;


  }

}