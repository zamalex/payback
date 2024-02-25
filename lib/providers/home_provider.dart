import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:payback/data/repository/home_repo.dart';
import 'package:payback/model/categories_response.dart';
import 'package:payback/model/commitment_model.dart';
import 'package:payback/model/onboarding_response.dart';
import 'package:payback/model/partner_model.dart';

import '../data/repository/auth_repo.dart';
import '../data/service_locator.dart';
import '../model/product_model.dart';



class HomeProvider extends ChangeNotifier{

  bool isLoading=false;

  List<Category>? categories = [];
  List<Data>? onBoarding = [];


   List<Product> products=[];
   List<Commitment> commitments=[];
   List<Partner> vendors=[];
   List<Partner> partners=[];

  Future<Map<String, dynamic>> getVendors() async {
    // Implement your loading logic here if needed
    // ...

    final response = await sl<HomeRepository>().getVendors();
    if (response.containsKey('data')) {
      vendors = response['data'];
    }


    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> getPartners() async {
    // Implement your loading logic here if needed
    // ...

    final response = await sl<HomeRepository>().getPartners();
    if (response.containsKey('data')) {
      partners = response['data'];
    }


    notifyListeners();
    return response;
  }
  Future<Map<String, dynamic>> getCommitments() async {

    final response = await sl<HomeRepository>().getCommitments();
    if (response.containsKey('data')) {
      commitments = response['data'];
    }



    notifyListeners();
    return response;
  }


  Future<Map<String, dynamic>> getProducts() async {

    final response = await sl<HomeRepository>().getProducts();
    if (response.containsKey('data')) {
      products = response['data'];
    }



    notifyListeners();
    return response;
  }



  Future<Map> getOnBoarding()async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<HomeRepository>().getOnBoarding();
    onBoarding = response['data'];

    isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Map> getCategories()async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<HomeRepository>().getCategories();
    categories = response['data'];

    isLoading = false;
    notifyListeners();

    return response;
  }



}