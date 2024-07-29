import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
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

  Future createOrder(Map<String, dynamic> body) async {
    try {
      Response response = await sl<DioClient>()
          .post(Url.CREATE_ORDER_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        double cashback = 0;

        try {
          if (parsedJson['data']) {
            if ((parsedJson['data']['order_items'] as List).isNotEmpty) {
              if ((parsedJson['data']['order_items'] as List)
                      .first['product'] !=
                  null) {
                Map json = (parsedJson['data']['order_items'] as List)
                    .first['product'];

                cashback = (json['cashback_value'] != null &&
                        (json['cashback_value'] as List).isNotEmpty)
                    ? double.parse((json['cashback_value'] as List)
                        .first['cashback_value']
                        .toString())
                    : 0;
              }
            }
          }
        } catch (e) {
          cashback = 0;
        }

        return {
          'message': 'order done',
          'data': true,
          'amount': parsedJson['data']['amount'].toString(),
          'id': parsedJson['data']['id'].toString(),
          'cashback': cashback,
          'created_at': parsedJson['data']['created_at'].toString()
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

  String computeHash(String id, String amount, String currency,
      String description, String password) {
    // Concatenate the inputs
    String concatenated = '$id$amount$currency$description$password';

    // Convert to uppercase
    String uppercased = concatenated.toUpperCase();
    print('upper:$uppercased');

    // Compute the MD5 hash
    var md5Hash = md5.convert(utf8.encode(uppercased)).toString();
    print('md5:$md5Hash');

    // Compute the SHA-1 hash of the MD5 result
    var sha1Hash = sha1.convert(utf8.encode(md5Hash)).toString();
    print('sha1:$sha1Hash');

    return sha1Hash;
  }

  Future generatePaymentUrl(
    Map<String, dynamic> body,
  ) async {
    try {
      User user = sl<AuthResponse>().data!.user!;
      String hash = computeHash(
          body['order_id'].toString(),
          body['order_amount'].toString(),
          'SAR',
          'order',
          '301d32068ef211f64c6af7287558e77f');

      body.putIfAbsent(
        'action',
        () => 'SALE',
      );
      body.putIfAbsent(
        'edfa_merchant_id',
        () => 'f3830a26-62e5-4723-8ac6-5549f816be5b',
      );
      body.putIfAbsent(
        'order_currency',
        () => 'SAR',
      );
      body.putIfAbsent(
        'order_description',
        () => 'order',
      );
      body.putIfAbsent(
        'req_token',
        () => 'N',
      );
      body.putIfAbsent(
        'payer_first_name',
        () => 'mr',
      );
      body.putIfAbsent(
        'payer_last_name',
        () => user.name,
      );
      body.putIfAbsent(
        'payer_email',
        () => user.email,
      );
      body.putIfAbsent(
        'payer_address',
        () => user.email,
      );
      body.putIfAbsent(
        'payer_phone',
        () => user.phone,
      );
      body.putIfAbsent(
        'payer_ip',
        () => '176.44.76.22',
      );
      body.putIfAbsent(
        'term_url_3ds',
        () =>
            '${Url.BASE_URL}/success?payment_id=${hash}&order_id=${body['order_id']}&amount=${body['order_amount']}&payment_type=order&user_id=${sl<AuthResponse>().data!.user!.id}',
      );
      body.putIfAbsent(
        'auth',
        () => 'N',
      );
      body.putIfAbsent(
        'payer_country',
        () => 'SA',
      );
      body.putIfAbsent(
        'payer_city',
        () => 'Riyadh',
      );
      body.putIfAbsent(
        'payer_zip',
        () => '12221',
      );
      body.putIfAbsent(
        'recurring_init',
        () => 'N',
      );
      body.putIfAbsent(
        'hash',
        () => hash,
      );

      print('request ${body.toString()}');

      var data = FormData.fromMap(body);

      var dio = Dio();
      var response = await dio.request(
        '${Url.BASE_URL}/payment/initiate',
        //  'https://api.edfapay.com/payment/initiate',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'Bearer ${sl.isRegistered<AuthResponse>() ? sl<AuthResponse>().data!.token ?? '' : ''}'
          },
          method: 'POST',
        ),
        data: data,
      );

      final parsedJson = response.data;

      print('response ${parsedJson}');

      // Extract the URL
      String url = parsedJson['response'];
      if (response.statusCode! < 400) {
        return {
          'url': url,
          'message': 'canceled',
          'data': true,
        };
      }

      return {'message': 'Not found', 'data': false};
    } catch (e) {
      print('error ${e.toString()}');
      if (e is DioError) {
        return {'message': e.message, 'data': false};
      } else {
        return {'message': 'Unknown error', 'data': false};
      }
    }
  }

  Future cancelOrder(Map<String, dynamic> body, int id) async {
    try {
      Response response = await sl<DioClient>().put('${Url.CORDERS_URL}/$id',
          data: jsonEncode(body), queryParameters: body);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        return {
          'message': 'canceled',
          'data': true,
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

  Future reOrder(Map<String, dynamic> body, int id) async {
    try {
      Response response = await sl<DioClient>().put('${Url.CORDERS_URL}/$id',
          data: jsonEncode(body), queryParameters: body);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        return {
          'message': 'canceled',
          'data': true,
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
      Response response = await sl<DioClient>().get(
        Url.CORDERS_URL,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<Order> orders = data.map((json) => Order.fromJson(json)).toList();
        return {'data': orders};
      } else {
        return {'data': []};
      }
    } catch (e) {
      print(e.toString());
      return {'data': []};
    }
  }

  Future<List<PaymentSetting>> getPaymentMethods() async {
    try {
      Response response = await sl<DioClient>().get(
        Url.PAYMENTS_URL,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return List<PaymentSetting>.from(
            data.map((item) => PaymentSetting.fromJson(item)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
