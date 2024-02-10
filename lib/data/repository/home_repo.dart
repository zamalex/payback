import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:payback/model/categories_response.dart';
import 'package:payback/model/onboarding_response.dart';


import '../../model/auth_response.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class HomeRepository {
  Future getCategories() async {

    CategoriesResponse loginModel = CategoriesResponse.fromJson(jsonDecode(Url.mocCategories));
    return {'message': 'Welcome', 'data':(loginModel.categories??[]) as List<Category>};

    try {
      Response response =
      await sl<DioClient>().get(Url.CATEGORIES_URL,);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        CategoriesResponse loginModel = CategoriesResponse.fromJson(parsedJson);
        return {'message': 'Welcome', 'data':(loginModel.categories??[]) as List<Category>};
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error'};
      }
    }
  }
  Future getProducts() async {

    try {
      Response response =
      await sl<DioClient>().get(Url.PRODUCTS_URL,);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        CategoriesResponse loginModel = CategoriesResponse.fromJson(parsedJson);
        return {'message': 'Welcome', 'data':(loginModel.categories??[]) as List<Category>};
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error'};
      }
    }
  }


  Future getOnBoarding() async {

    var json = """{
"success": true,
"status": 200,
"data": [
{
"id": 1,
"title": "Titleiure tae deserunt",
"description": "In placeat explicabo Impedit laboriosam neque",
"image": "assets/images/splash_pic_1.png",
"sort": 1,
"is_active": 1
},
{
"id": 1,
"title": "Titleiure tae deserunt",
"description": "In placeat explicabo Impedit laboriosam neque",
"image": "assets/images/splash_pic_2.png",
"sort": 1,
"is_active": 1
}
],
"message": "List Of Screens"
}""";

    OnBoardingResponse loginModel = OnBoardingResponse.fromJson(jsonDecode(json));
    return {'message': 'Welcome', 'data':(loginModel.data??[]) as List<Data>};
    try {
      Response response =
      await sl<DioClient>().get(Url.ONBOARDING_URL,);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        CategoriesResponse loginModel = CategoriesResponse.fromJson(parsedJson);
        return {'message': 'Welcome', 'data':(loginModel.categories??[]) as List<Category>};
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error'};
      }
    }
  }




}
