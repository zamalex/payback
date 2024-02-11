import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';


import '../../model/auth_response.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class AuthRepository {
  Future login(String phone, String password, String type) async {
    Map<String, String> body = {
      'password': password,
      'email': phone
    };
    try {
      Response response =
          await sl<DioClient>().post(Url.LOGIN_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        AuthResponse loginModel = AuthResponse.fromJson(parsedJson);
        return {'message': 'Welcome', 'data': loginModel};
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.response?.data['message']??e.message};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error'};
      }
    }
  }

  Future register(Map<String, String> body) async {
    try {
      Response response =
      await sl<DioClient>().post(Url.REGISTER_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        //UserModel loginModel = UserModel.fromJson(parsedJson);
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        String error = e.response?.data['message']??
            e.message;

        if(e.response!.data.toString().contains('email')||e.response!.data.toString().contains('phone')){
            error = 'Account Already Registered';
        }

        return {'message':  error, 'data': false};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }

  Future<Map> verify(Map<String, String> body) async {
    try {
      Response response =
      await sl<DioClient>().post(Url.VERIFY_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        AuthResponse loginModel = AuthResponse.fromJson(parsedJson);
        return {'message': loginModel.message, 'data': loginModel};
      }

      return {'message': 'Server Error'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message,};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error',};
      }
    }
  }


}
