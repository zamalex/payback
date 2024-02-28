import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payback/screens/login.dart';

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