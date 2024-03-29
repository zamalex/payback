import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:payback/model/commitment_model.dart';
import 'package:payback/model/share_details_response.dart';

import '../../helpers/dio_error_helper.dart';
import '../../model/cashback_dashboard.dart';
import '../../model/partner_model.dart';
import '../../model/transactions_response.dart';
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

  Future editCommitment(Map<String, dynamic> body,int id) async {
    try {
      Response response =
      await sl<DioClient>().put('${Url.COMMIMENTS_URL}/$id', data: jsonEncode(body));

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
        return {'message': parsedJson['message'], 'data': true};
      }

      return {'message':  parsedJson['message'], 'data': false};
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
        return {'message': 'Done', 'data': parsedJson['data']};
      }

      return {'message': 'Error', };
    } catch (e) {
      if (e is DioError) {
        return {'message':  DioErrorHelper.handleError(e),};


      } else {
        return {'message': 'unknown error',};
      }
    }
  }


  Future<Map<String, dynamic>> getInvitationDetails(int id) async {
    try {
      Response response = await sl<DioClient>().get('${Url.SHARE_INVITATION_URL}/$id',);

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        ShareDetailsResponse shareDetailsResponse= ShareDetailsResponse.fromJson(parsedJson);

        return {'message': 'Partners retrieved successfully', 'data': shareDetailsResponse};
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


  Future<CashBackHistory?> getCashbackHistory(Map<String,dynamic>? params) async {
    try {
      Response response = await sl<DioClient>().get(Url.GET_CASHBACK_HISTORY_URL,queryParameters: params);


      if (response.statusCode == 200) {
        CashBackHistory  cashBackHistory = CashBackHistory.fromJson(response.data);

        cashBackHistory.categories!.forEach((element) {
          element.summary!.calculateFromAll(cashBackHistory.categories!);
        });

        return cashBackHistory;
      } else {
        throw Exception('Failed to load summary');
      }
    } catch (error) {
      throw Exception('Failed to load summary: $error');
    }
  }




  Future<Map> getCommitmentsOfCategory(Map<String,dynamic>? params) async {
    try {
      Response commitmentsRes = await sl<DioClient>().get(Url.COMMIMENTS_URL,queryParameters: params);
      Response transactionsRes = await sl<DioClient>().get(Url.GET_CASHBACK_TRANSACTIONS_URL,queryParameters: params);

      final parsedJson = commitmentsRes.data;
      if (commitmentsRes.statusCode! < 400&&transactionsRes.statusCode! < 400) {
        List<Commitment> commitments = (parsedJson['data'] as List)
            .map((json) => Commitment.fromJson(json))
            .toList();

        List<Commitment> someCommitments=[];
        List<Transaction> transactions = List<Transaction>.from(transactionsRes.data['data'].map((x) => Transaction.fromJson(x)));

        if(transactions.isNotEmpty){
          transactions.forEach((trans) {
            if(trans.reference!=null)
            someCommitments.addAll(commitments.where((comm) => comm.name==trans.reference!.name).toList());

          });

        }else{
          someCommitments.clear();
        }


        return {'message': 'Commitments retrieved successfully', 'data': someCommitments};
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