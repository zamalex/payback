
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/data/repository/checkout_repo.dart';
import 'package:payback/model/payment_model.dart';
import 'package:payback/model/product_model.dart';
import 'package:payback/model/shipping_model.dart';
import 'package:payback/screens/checkout_object.dart';

import '../data/service_locator.dart';
import '../model/orders_model.dart';

class CheckoutProvider extends ChangeNotifier{

  String selectedStatus = 'completed';

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
  List<ShippingMethod> shippingsAddresses = [];
  List<Order> orders=[];
  List<PaymentSetting> paymentMethods=[];


  Future loadOrders() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await sl<CheckoutRepository>().getOrders();
      orders = response['data'];

      orders = orders.where((element) => element.status==selectedStatus).toList();
    } catch (e) {
      orders=[];
    }

    isLoading = false;
    notifyListeners();
  }
  Future getPaymentMethods() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await sl<CheckoutRepository>().getPaymentMethods();
      paymentMethods = response;

    } catch (e) {
      paymentMethods=[];
    }

    isLoading = false;
    notifyListeners();
  }

  readCart(List<Product>pros,List<Product>?qrProducts)async{

    if(qrProducts!=null){
      cart = qrProducts;

      cart.forEach((element) { element.cartQuantity=1;});


      await sl<PreferenceUtils>().saveCart(cart);

      readCart(pros, null);

      return;
    }
    else{
      cart = await sl<PreferenceUtils>().readCart();
      syncCartProducts(pros);

      groupProductsByVendor();
    }

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

  Future<Map<String, dynamic>> getShippingAddresses() async {

    final response = await sl<CheckoutRepository>().getShippingAddresses();
    if (response.containsKey('data')) {
      shippingsAddresses = response['data'];
    }



    notifyListeners();
    return response;
  }

  syncCartProducts(List<Product> prods) {
    List<Product> cartCopy = List.from(cart); // Create a copy of the cart list

    cartCopy.forEach((c) {
      Product? p = prods.firstWhereOrNull((element) => c.id == element.id);

      if (p != null) {
        c = p..cartQuantity = c.cartQuantity; // Update the original cart list
      } else {
        cart.removeWhere((element) => element.id == c.id); // Modify the original cart list
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