import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:payback/helpers/dio_error_helper.dart';
import 'package:payback/model/notifications_response.dart';

import '../../model/auth_response.dart';
import '../../model/orders_model.dart';
import '../../model/payment_model.dart';
import '../../model/shipping_model.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class CheckoutRepository {
  Future getShippingMethods() async {
    try {
      Response response = await sl<DioClient>().get(Url.DELIVERY_URL);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<ShippingMethod> shippingMethods = (parsedJson['data'] as List)
            .map((json) => ShippingMethod.fromJson(json))
            .toList();

        return {
          'message': 'Shipping methods retrieved successfully',
          'data': shippingMethods
        };
      }

      return {'message': 'Not found', 'data': []};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message, 'data': []};
      } else {
        return {'message': 'Unknown error', 'data': []};
      }
    }
  }

  Future getShippingAddresses() async {
    try {
      Response response = await sl<DioClient>().get(Url.DELIVERY_URL);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        List<ShippingMethod> shippingMethods = (parsedJson['data'] as List)
            .map((json) => ShippingMethod.fromJson(json))
            .toList();

        return {
          'message': 'Shipping methods retrieved successfully',
          'data': shippingMethods
        };
      }

      return {'message': 'Not found', 'data': []};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message, 'data': []};
      } else {
        return {'message': 'Unknown error', 'data': []};
      }
    }
  }



  Future createOrder(Map<String,dynamic> body) async {
    try {
      Response response = await sl<DioClient>().post(Url.CREATE_ORDER_URL,data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {

        return {
          'message': 'order done',
          'data': true,
          'amount':parsedJson['data']['amount'].toString(),
          'created_at':parsedJson['data']['created_at'].toString()
        };
      }

      return {'message': 'Not found', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.message, 'data': false};
      } else {
        return {'message': 'Unknown error', 'data': false};
      }
    }
  }


  Future<Map> getOrders() async {
    try {
      Response response = await sl<DioClient>().get(Url.CORDERS_URL,);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<Order> orders = data.map((json) => Order.fromJson(json)).toList();
        return {'data':orders};
      } else {
        return {'data':[]};
      }
    } catch (e) {
      return {'data':[]};
    }
  }


  Future<List<PaymentSetting>> getPaymentMethods() async {
    try {
      Response response = await sl<DioClient>().get(Url.PAYMENTS_URL,);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return List<PaymentSetting>.from(data.map((item) => PaymentSetting.fromJson(item)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
