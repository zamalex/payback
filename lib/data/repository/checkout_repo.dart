import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:payback/helpers/dio_error_helper.dart';
import 'package:payback/model/notifications_response.dart';

import '../../model/auth_response.dart';
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
}
