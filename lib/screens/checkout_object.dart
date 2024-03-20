import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class CheckoutObject{

   int selectedDelivery=0;
  int selectedPickup = 0;
  int vendor=0;

   final selfFormKey = GlobalKey<FormState>();
   final courierFormKey = GlobalKey<FormState>();

   TextEditingController addressController = TextEditingController();

   String? officeAddress;
  String? city;
  String? street;
  String? building;
  String? apartment;
  String? comments;


  List<Product> products=[];

   double getTotalPrice() {
     double total = 0.0;
     for (Product product in products) {
       total += product.cartQuantity * double.parse(product.price??'0');
     }
     return total;
   }

   List<Map> getItems(){
     List<Map> items = [];
     products.forEach((element) {
       Map m = {
         "product_id": element.id,
         "quantity": element.cartQuantity,
         "price": double.parse(element.price??'0'),
         "tax_amount": 0,
       };

       items.add(m);
     });

     return items;
   }



  CheckoutObject({required this.vendor,required this.selectedDelivery,required this.selectedPickup,this.products=const[]});

}
