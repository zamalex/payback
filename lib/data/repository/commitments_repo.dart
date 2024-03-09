import 'dart:convert';

import 'package:dio/dio.dart';

import '../../helpers/dio_error_helper.dart';
import '../../model/partner_model.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class CommitmentsRepository{

  Future createCommitment(Map<String, dynamic> body) async {
    try {
      Response response =
      await sl<DioClient>().post(Url.CREATE_COMMIMENTS_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message':  DioErrorHelper.handleError(e), 'data': false};


      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }


  Future deleteCommitment(int id) async {
    try {
      Response response =
      await sl<DioClient>().delete('${Url.COMMIMENTS_URL}/$id',);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message':  DioErrorHelper.handleError(e), 'data': false};


      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }

  Future<Map<String, dynamic>> getCommitmentsCategories() async {
    try {
      Response response = await sl<DioClient>().get(Url.COMMIMENTS_CATEGORIES_URL);

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


  Future acceptRejectInvitation(Map<String, dynamic> body,int id) async {
    try {
      Response response =
      await sl<DioClient>().put('${Url.SHARE_INVITATION_URL}/$id', data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message':  DioErrorHelper.handleError(e), 'data': false};


      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }


  Future sendInvitation(Map<String, dynamic> body) async {
    try {
      Response response =
      await sl<DioClient>().post(Url.SHARE_INVITATION_URL, data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        return {'message': 'Done', 'data': true};
      }

      return {'message': 'Error', 'data': false};
    } catch (e) {
      if (e is DioError) {
        return {'message':  DioErrorHelper.handleError(e), 'data': false};


      } else {
        return {'message': 'unknown error', 'data': false};
      }
    }
  }


  Future<Map<String, dynamic>> getInvitationDetails(int id) async {
    try {
      Response response = await sl<DioClient>().get('${Url.SHARE_INVITATION_URL}/$id',);

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