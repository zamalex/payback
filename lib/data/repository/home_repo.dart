import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:payback/model/categories_response.dart';


import '../../model/auth_response.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class HomeRepository {
  Future getCategories() async {

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
