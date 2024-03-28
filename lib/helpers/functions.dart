import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payback/screens/login.dart';

import '../model/product_model.dart';

void showErrorMessage(BuildContext context,String error){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error),backgroundColor: Colors.red),);
}

void showSuccessMessage(BuildContext context,String error){


  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error),backgroundColor: Colors.green),);
}

void showGoToLogin(){
  Get.snackbar('Unauthorized','Please login first or register' ,backgroundColor: Colors.red,colorText: Colors.white);
  Get.to(LoginScreen());
}

double calculateCartTotal(List<Product> pros){
  double total = 0;

  pros.forEach((element) { total+=double.parse(element.price??'0');});

  return total;
}

String parseDate(String s){
  DateTime dateTime = DateTime.parse(s);

  // Format the DateTime object into a readable format
  String formattedDateTime = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';

  return formattedDateTime;
}