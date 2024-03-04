import 'package:flutter/cupertino.dart';

import '../model/product_model.dart';

class CheckoutObject{

   int selectedDelivery=0;
  int selectedPickup = 0;
  int vendor=0;

   final selfFormKey = GlobalKey<FormState>();
   final courierFormKey = GlobalKey<FormState>();


   String? officeAddress;
  String? city;
  String? street;
  String? building;
  String? apartment;
  String? comments;


  List<Product> products=[];



  CheckoutObject({required this.vendor,required this.selectedDelivery,required this.selectedPickup,this.products=const[]});

}
