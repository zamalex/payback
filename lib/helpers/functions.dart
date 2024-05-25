import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
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

String formatDateRange(DateTime from, DateTime to) {
  DateFormat dayMonthFormat = DateFormat('d MMMM');
  DateFormat yearFormat = DateFormat('yyyy');

  String fromFormatted = dayMonthFormat.format(from);
  String toFormatted = dayMonthFormat.format(to);
  String yearFormatted = yearFormat.format(to);

  return '$fromFormatted - $toFormatted $yearFormatted';
}

double calculateCashback(List<Product> pros){
  double total = 0;


  try{
    pros.forEach((element) {
      if(element.cartQuantity>=element.quantity_from!){
        int q = element.cartQuantity%element.quantity_to!;
        if(q==0){
          q=( element.cartQuantity/element.quantity_to!).toInt();
          q=1;
        }
        else{
          q=1;
        }
        total+=(element.cashback!*q);
      }


    });
  }catch(e){

  }


  return total;
}



String parseDate(String s){
  DateTime dateTime = DateTime.parse(s);

  // Format the DateTime object into a readable format
  String formattedDateTime = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';

  return formattedDateTime;
}