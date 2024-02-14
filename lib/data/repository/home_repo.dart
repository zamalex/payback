import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:payback/model/categories_response.dart';
import 'package:payback/model/onboarding_response.dart';


import '../../model/auth_response.dart';
import '../../model/commitment_model.dart';
import '../../model/partner_model.dart';
import '../../model/product_model.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class HomeRepository {
  Future getCategories() async {

    //CategoriesResponse loginModel = CategoriesResponse.fromJson(jsonDecode(Url.mocCategories));
    //return {'message': 'Welcome', 'data':(loginModel.categories??[]) as List<Category>};

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
  Future<Map<String, dynamic>> getProducts() async {
    try {
      Response response = await sl<DioClient>().get(Url.PRODUCTS_URL);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<Product> products = (parsedJson['data'] as List)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        return {'message': 'Products retrieved successfully', 'data': products};
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message};
      } else {
        return {'message': 'Unknown error'};
      }
    }
  }


  Future<Map<String, dynamic>> getCommitments() async {
    try {
      Response response = await sl<DioClient>().get(Url.COMMIMENTS_URL);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<Commitment> commitments = (parsedJson['data'] as List)
            .map((json) => Commitment.fromJson(json))
            .toList();

        return {'message': 'Commitments retrieved successfully', 'data': commitments};
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message};
      } else {
        return {'message': 'Unknown error'};
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

  Future<Map<String, dynamic>> getPartners() async {
    try {
      Response response = await sl<DioClient>().get(Url.PARTNERS_URL);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<Partner> partners = (parsedJson['data'] as List)
            .map((json) => Partner.fromJson(json))
            .toList();

        return {'message': 'Partners retrieved successfully', 'data': partners};
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message};
      } else {
        return {'message': 'Unknown error'};
      }
    }
  }


}
