import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:payback/model/categories_response.dart';
import 'package:payback/model/cities_response.dart';
import 'package:payback/model/onboarding_response.dart';
import 'package:payback/model/partner_custom_fields_response.dart';


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
  Future<Map<String, dynamic>> getProducts(Map<String,dynamic>filters) async {
    try {
      Response response = await sl<DioClient>().get(Url.PRODUCTS_URL,queryParameters: filters);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<Product> products = (parsedJson['data'] as List)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        return {'message': 'Products retrieved successfully', 'data': products};
      }

      return {'message': 'Not found','data':[] as List<Product>};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,'data':[] as List<Product>};
      } else {
        return {'message': 'Unknown error','data':[] as List<Product>};
      }
    }
  }



  Future<Map<String, dynamic>> getSavedProducts() async {
    try {
      Response response = await sl<DioClient>().get(Url.PRODUCTS_URL,queryParameters: {'is_saved':1});

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<Product> products = (parsedJson['data'] as List)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        return {'message': 'Products retrieved successfully', 'data': products};
      }

      return {'message': 'Not found','data':[] as List<Product>};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,'data':[] as List<Product>};
      } else {
        return {'message': 'Unknown error','data':[] as List<Product>};
      }
    }
  }


  Future<Map<String, dynamic>> saveProduct(Product product) async {
    try {
      Response response = await sl<DioClient>().post('${Url.PRODUCTS_URL}/${product.id}/add-to-save',data: {'product_id':product.id});

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
       /* List<Product> products = (parsedJson['data'] as List)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
*/
        return {'message': 'Products retrieved successfully', 'data':[]};
      }

      return {'message': 'Not found','data':[] as List<Product>};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,'data':[] as List<Product>};
      } else {
        return {'message': 'Unknown error','data':[] as List<Product>};
      }
    }
  }


  Future<Map<String, dynamic>> savePartner(Partner partner) async {
    try {
      Response response = await sl<DioClient>().post('${Url.Vendorrs_URL}/${partner.id}/add-to-save',data: {
        'vendor_id':partner.id
      });

      final parsedJson = response.data;
      if (response.statusCode! < 400) {


        return {'message': 'Products retrieved successfully', 'data': []};
      }

      return {'message': 'Not found','data':[] as List<Product>};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,'data':[] as List<Product>};
      } else {
        return {'message': 'Unknown error','data':[] as List<Product>};
      }
    }
  }


  Future<Map<String, dynamic>> getCommitments() async {
    try {
      Response response = await sl<DioClient>().get(Url.COMMIMENTS_URL,);

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

  Future<Map<String, dynamic>> reOrderCommitments(List<int> sort) async {
    try {
      Response response = await sl<DioClient>().post(Url.SORT_COMMIMENTS_URL,data: jsonEncode({'sort':sort}));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {

        return {'message': 'Commitments sorted successfully', 'data': true};
      }

      return {'message': 'Not found','data':false};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,'data':false};
      } else {
        return {'message': 'Unknown error','data':false};
      }
    }
  }

  Future<List<City>> getCities() async {
    try {
      Response response = await sl<DioClient>().get(Url.CITIES_URL);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<City> cities = (parsedJson['data'] as List)
            .map((json) => City.fromJson(json))
            .toList();

        return cities;
      }

      return [];
    } catch (e) {
      if (e is DioError) {
        return [];
      } else {
        return [];
      }
    }
  }
  Future getOnBoarding() async {

    /*var json = """{
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
    return {'message': 'Welcome', 'data':(loginModel.data??[]) as List<Data>};*/
    try {
      Response response =
      await sl<DioClient>().get(Url.ONBOARDING_URL,);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        OnBoardingResponse loginModel = OnBoardingResponse.fromJson(parsedJson);
        return {'message': 'Welcome', 'data':(loginModel.data??[]) as List<Data>};
      }

      return {'message': 'Not found','data':[]};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error'};
      }
    }
  }

  Future<Map<String, dynamic>> getSavedVendors() async {
    try {
      Response response = await sl<DioClient>().get(Url.Vendorrs_URL,queryParameters: {'is_saved':1});

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<Partner> partners = (parsedJson['data'] as List)
            .map((json) => Partner.fromJson(json))
            .toList();

        return {'message': 'Partners retrieved successfully', 'data': partners};
      }

      return {'message': 'Not found','data':[]};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,'data':[]};
      } else {
        return {'message': 'Unknown error','data':[]};
      }
    }
  }  Future<Map<String, dynamic>> getVendors() async {
    try {
      Response response = await sl<DioClient>().get(Url.Vendorrs_URL);

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
  Future<Map<String, dynamic>> getPartnerCustomFields(int id) async {
    try {
      Response response = await  sl<DioClient>().get('${Url.PARTNERS_CUSTOM_FIELDS_URL}${id}/fields');

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        PartnerCustomFieldsResponse partner = PartnerCustomFieldsResponse.fromJson(parsedJson['data']as Map<String,dynamic>);
        return {'message': 'Partner retrieved successfully', 'data': partner.customFields};
      }

      return {'message': 'Not found','data':[]};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,'data':[]};
      } else {
        return {'message': 'Unknown error','data':[]};
      }
    }
  }

}
