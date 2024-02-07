import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:payback/data/repository/home_repo.dart';
import 'package:payback/model/categories_response.dart';
import 'package:payback/model/onboarding_response.dart';

import '../data/repository/auth_repo.dart';
import '../data/service_locator.dart';



class HomeProvider extends ChangeNotifier{

  bool isLoading=false;

  List<Category>? categories = [];
  List<Category>? products = [];
  List<Data>? onBoarding = [];






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
  Future<Map> getProducts()async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<HomeRepository>().getProducts();
    products = response['data'];

    isLoading = false;
    notifyListeners();

    return response;
  }



}