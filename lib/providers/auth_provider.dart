import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../data/repository/auth_repo.dart';
import '../data/service_locator.dart';



class AuthProvider extends ChangeNotifier{

  bool isLoading=false;


  Future<Map> socialLogin(Map<String,String> body)async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<AuthRepository>().socialLogin(body);

    isLoading = false;
    notifyListeners();

    return response;
  }



Future<Map> register(Map<String,String> body)async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<AuthRepository>().register(body);

    isLoading = false;
    notifyListeners();

    return response;
  }




  Future<Map> login(String phone,String password,String type)async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<AuthRepository>().login(phone,password,type);

    isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Map> forgotPassword(Map<String,String> request)async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<AuthRepository>().forgotPassword(request);

    isLoading = false;
    notifyListeners();

    return response;
  }


  Future<Map> checkForgotToken(Map<String,String> request)async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<AuthRepository>().checkForgotToken(request);

    isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Map> resetPassword(Map<String,String> request)async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<AuthRepository>().resetPassword(request);

    isLoading = false;
    notifyListeners();

    return response;
  }



  Future<Map> verify(Map<String,String> body)async{
    isLoading = true;
    notifyListeners();

    Map response= await sl<AuthRepository>().verify(body);

    isLoading = false;
    notifyListeners();

    return response;
  }



}