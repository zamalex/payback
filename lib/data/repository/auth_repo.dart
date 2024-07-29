import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/helpers/dio_error_helper.dart';
import 'package:payback/model/cashbak_response.dart';
import 'package:payback/model/notifications_response.dart';

import '../../model/auth_response.dart';
import '../../model/sbscription_plan.dart';
import '../../model/settings_response.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class AuthRepository {
  Future login(String phone, String password, String type) async {
    Map<String, String> body = {'password': password, 'email': phone};
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
        return {'message': e.response?.data['message'] ?? e.message};
      } else {
        return {'message': 'unknown error'};
      }
    }
  }

  Future deleteAccount() async {
    try {
      Response response = await sl<DioClient>().delete(
        '${Url.USERS_URL}/${sl<AuthResponse>().data!.user!.id!}',
      );

      if (response.statusCode! < 400) {
        return {
          'message': 'Welcome',
        };
      }

      return {'message': 'Not found'};
    } catch (e) {
      if (e is DioError) {
        return {'message': e.response?.data['message'] ?? e.message};
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
        return {'message': DioErrorHelper.handleError(e), 'data': false};

        String error = e.response?.data['message'] ?? e.message;

        if (e.response!.data.toString().contains('email') ||
            e.response!.data.toString().contains('phone')) {
          error = 'Account Already Registered';
        }

        return {'message': error, 'data': false};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }

  Future<Map> socialLogin(Map<String, String> body) async {
    try {
      Response response = await sl<DioClient>()
          .post(Url.SOCIAL_LOGIN_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        AuthResponse loginModel = AuthResponse.fromJson(parsedJson);
        return {'message': 'Welcome', 'data': loginModel};
      }

      return {'message': 'Error', 'data': null};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': null};
      } else {
        return {'message': 'unknown error', 'data': null};
      }
    }
  }

  Future forgotPassword(Map<String, String> body) async {
    try {
      Response response =
          await sl<DioClient>().post(Url.FORGOT_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        //UserModel loginModel = UserModel.fromJson(parsedJson);
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': false};
      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }

  Future checkForgotToken(Map<String, String> body) async {
    try {
      Response response = await sl<DioClient>()
          .post(Url.CHECK_TOKEN_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        //UserModel loginModel = UserModel.fromJson(parsedJson);
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': false};
      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }

  Future resetPassword(Map<String, String> body) async {
    try {
      Response response = await sl<DioClient>()
          .post(Url.RESET_PASSWORD_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        //UserModel loginModel = UserModel.fromJson(parsedJson);
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': false};
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
        String error = e.response?.data['message'] ?? e.message;
        return {
          'message': error,
        };
        //return {'message':e.message};
      } else {
        return {
          'message': 'unknown error',
        };
      }
    }
  }

  Future<bool> sendFCMToken(Map<String, String> body) async {
    try {
      Response response = await sl<DioClient>()
          .post(Url.SEND_FCM_TOKEN_URL, data: jsonEncode(body));

      if (response.statusCode! < 400) {
        return true;
      }

      return false;
    } catch (e) {
      if (e is DioError) {
        return false; //return {'message':e.message};
      } else {
        return false;
      }
    }
  }

  Future<Map> updateUserData(Map<String, String> body) async {
    try {
      Response response = await sl<DioClient>()
          .put(Url.UPDATE_USER_DATA_URL, data: jsonEncode(body));

      String message = response.data['message'];
      if (response.statusCode! < 400) {
        AuthResponse authResponse = sl<AuthResponse>();
        authResponse.data!.user = User.fromJson(response.data['data']);
        sl<PreferenceUtils>().saveUser(authResponse);

        return {'message': message, 'data': true};
      }

      return {'message': message, 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': false};
        //return {'message':e.message};
      } else {
        return {'message': 'Server Error', 'data': false};
      }
    }
  }

  Future<Map> updateUserEmail(Map<String, String> body) async {
    try {
      Response response = await sl<DioClient>()
          .put(Url.UPDATE_USER_EMAIL_URL, data: jsonEncode(body));

      String message = response.data['message'];
      if (response.statusCode! < 400) {
        AuthResponse authResponse = sl<AuthResponse>();
        authResponse.data!.user = User.fromJson(response.data['data']);
        sl<PreferenceUtils>().saveUser(authResponse);

        return {'message': message, 'data': true};
      }

      return {'message': message, 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': false};
        //return {'message':e.message};
      } else {
        return {'message': 'Server Error', 'data': false};
      }
    }
  }

  Future<CashbackModel> getCashback() async {
    try {
      Response response = await sl<DioClient>().get(Url.GET_CASHBACK_URL);
      if (response.statusCode == 200) {
        return CashbackModel.fromJson(response.data['data']);
      } else {
        return CashbackModel.fromJson(jsonDecode(Url.NO_CASHBACK));
      }
    } catch (error) {
      return CashbackModel.fromJson(jsonDecode(Url.NO_CASHBACK));
    }
  }

  Future<Map> updateUserAvatar(File file) async {
    try {
      String fileName = file.path.split('/').last;

      // Create FormData object
      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      Response response = await sl<DioClient>()
          .post(Url.UPDATE_USER_AVATER_URL, data: formData);

      String message = response.data['message'];
      if (response.statusCode! < 400) {
        AuthResponse authResponse = sl<AuthResponse>();
        authResponse.data!.user = User.fromJson(response.data['data']);
        sl<PreferenceUtils>().saveUser(authResponse);

        return {'message': message, 'data': true};
      }

      return {'message': message, 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': false};
        //return {'message':e.message};
      } else {
        return {'message': 'Server Error', 'data': false};
      }
    }
  }

  Future<Map> updateUserPassword(Map<String, String> body) async {
    try {
      Response response = await sl<DioClient>()
          .post(Url.CHANGE_PASSWORD_URL, data: jsonEncode(body));

      String message = response.data['message'];
      if (response.statusCode! < 400) {
        return {'message': message, 'data': true};
      }

      return {'message': message, 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message': DioErrorHelper.handleError(e), 'data': false};
        //return {'message':e.message};
      } else {
        return {'message': 'Server Error', 'data': false};
      }
    }
  }

  Future<Map> getNotifications() async {
    try {
      Response response = await sl<DioClient>().get(
        Url.NOTIFICATIONS_URL,
      );

      final parsedJson = response.data;

      if (response.statusCode! < 400) {
        NotificationsResponse loginModel =
            NotificationsResponse.fromJson(parsedJson);
        return {'message': 'success', 'data': loginModel.notifications};
      }

      return {'message': 'Server Error', 'data': []};
    } catch (e) {
      if (e is DioError) {
        String error = e.response?.data['message'] ?? e.message;
        return {'message': error, 'data': []};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error', 'data': []};
      }
    }
  }

  Future<Map> markAsReadNotifications() async {
    try {
      Map body = {
        'read_at': 'skljdcn',
        'user_id': sl<AuthResponse>().data!.user!.id
      };
      Response response = await sl<DioClient>()
          .put('${Url.NOTIFICATIONS_URL}/2', data: jsonEncode(body));

      final parsedJson = response.data;

      if (response.statusCode! < 400) {
        NotificationsResponse loginModel =
            NotificationsResponse.fromJson(parsedJson);
        return {'message': 'success', 'data': loginModel.notifications};
      }

      return {'message': 'Server Error', 'data': []};
    } catch (e) {
      if (e is DioError) {
        String error = e.response?.data['message'] ?? e.message;
        return {'message': error, 'data': []};
        //return {'message':e.message};
      } else {
        return {'message': 'unknown error', 'data': []};
      }
    }
  }

  Future<Map> getSettings() async {
    try {
      Response response = await sl<DioClient>().get(
        Url.SETTINGS_URL,
      );
      if (response.statusCode == 200) {
        return {'data': SettingsResponse.fromJson(response.data)};
      } else {
        return {'data': null};
      }
    } catch (e) {
      return {'data': null};
    }
  }

  Future<String> getUsers() async {
    try {
      Response response = await sl<DioClient>().get(
        Url.USERS_URL,
      );
      if (response.statusCode == 200) {
        return response.data.toString();
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Future<List<Plan>> getSubscriptions() async {
    try {
      Response isResponse = await sl<DioClient>().get(
        '${Url.USERS_URL}/${sl<AuthResponse>().data!.user!.id}',
      );

      Response response = await sl<DioClient>().get(
        Url.SUBSCRIPTIONS_URL,
      );
      if (response.statusCode == 200) {
        dynamic id = isResponse.data['data']['subscription_id'];
        List<Plan> plans =
            response.data.map<Plan>((json) => Plan.fromJson(json)).toList();
        plans.forEach((element) {
          if (element.id.toString() == id.toString()) {
            element.isSubscribed = true;
          }
        });

        return plans;
      } else {
        return [];
      }
    } catch (e) {
      return [];
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

  Future<Map> subscribeToPlan(Map<String, dynamic> body) async {
    User user = sl<AuthResponse>().data!.user!;
    String hash = computeHash(
        body['order_id'].toString(),
        body['order_amount'].toString(),
        'SAR',
        'subscription',
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
      () => 'subscription',
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
          '${Url.BASE_URL}/success?payment_id=${hash}&order_id=${body['order_id']}&amount=${body['order_amount']}&payment_type=subscription&user_id=${sl<AuthResponse>().data!.user!.id}',
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

    try {
      debugPrint('request is : ${body.toString()}');
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

      String url = parsedJson['response'];

      if (response.statusCode == 200) {
        return {'message': response.data['message'], 'data': url};
      } else {
        return {'message': response.data['message'], 'data': null};
      }
    } catch (e) {
      return {'message': 'Failed to subscribe', 'data': null};
    }
  }
}
