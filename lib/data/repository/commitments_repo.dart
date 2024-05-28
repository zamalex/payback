import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:payback/model/commitment_model.dart';
import 'package:payback/model/contributor_model.dart';
import 'package:payback/model/share_details_response.dart';

import '../../helpers/dio_error_helper.dart';
import '../../model/cashback_dashboard.dart';
import '../../model/orders_model.dart';
import '../../model/partner_model.dart';
import '../../model/product_model.dart';
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


  Future acceptRejectInvitation(Map<String, dynamic> body,Map<String, dynamic> query) async {
    try {
      Response response =
      await sl<DioClient>().post('${Url.SHARE_INVITATION_URL}', data: jsonEncode(body),queryParameters: query);

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
      await sl<DioClient>().post('${Url.SHARE_INVITATION_URL}/url', data: jsonEncode(body));

      final parsedJson = response.data;
      if (response.statusCode! < 400) {
        return {'message': 'Done', 'data': parsedJson['url']};
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


  Future<Map<String, dynamic>> getInvitationDetails2(int user,int commitment) async {
    try {
      Response userResponse = await sl<DioClient>().get('${Url.USERS_URL}/$user',);
      Response commitmentResponse = await sl<DioClient>().get('${Url.COMMIMENTS_URL}/$commitment',);

      final parsedUser = userResponse.data;
      final parsedCommitment = commitmentResponse.data;
      if (userResponse.statusCode! < 400&&commitmentResponse.statusCode! < 400) {
        ShareUser shareUser= ShareUser.fromJson(parsedUser['data']);
        ShareCommit shareCommit= ShareCommit.fromJson(parsedCommitment['data']);

        return {'message': 'Partners retrieved successfully', 'data': ShareDetailsResponse(data: ShareDetails(id: 0,amount: '0',commitment: shareCommit,user: shareUser,))};
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

       /* if(transactions.isNotEmpty){
          transactions.forEach((trans) {
            if(trans.reference!=null)
            someCommitments.addAll(commitments.where((comm) => comm.name==trans.reference!.name).toList());

          });

        }else{
          someCommitments.clear();
        }*/
        if(transactions.isNotEmpty){
          transactions.forEach((trans) {
            if(trans.reference!=null)
              {
               someCommitments.addAll(commitments.where((comm) => comm.name==trans.reference!.name).toList());

                if(trans.reference!.commitment!=null){
                  bool add = true;
                  someCommitments.forEach((element) {
                    if(element.id==trans.reference!.commitment!.id){
                      add = false;
                    }
                  });
                  if(add)
                  someCommitments.add(trans.reference!.commitment!);

                }
              }

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




  Future<Map> getReceivedFromUsers(Map<String,dynamic>? params) async {
    try {

     // Response commitmentsRes = await sl<DioClient>().get(Url.COMMIMENTS_URL,queryParameters: params);
      Response transactionsRes = await sl<DioClient>().get(Url.GET_CASHBACK_TRANSACTIONS_URL,queryParameters: params);

     // final parsedJson = commitmentsRes.data;
      if (transactionsRes.statusCode! < 400) {


        List<ContributorModel> someCommitments=[];
        List<Transaction> transactions = List<Transaction>.from(transactionsRes.data['data'].map((x) => Transaction.fromJson(x)));

        if(transactions.isNotEmpty){
          transactions.forEach((trans) {
            if(trans.reference!=null&&trans.reference!.category=='Community')

              someCommitments.add(ContributorModel(amount: trans.amount,avatar:trans.reference!.avatar ,name: trans.reference!.name,commitment: trans.reference!.commitment));


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




  Future<Map> getCommitmentContributors(Map<String,dynamic>? params) async {
    try {
      print(params.toString());
     // Response commitmentsRes = await sl<DioClient>().get(Url.COMMIMENTS_URL,queryParameters: params);
      Response transactionsRes = await sl<DioClient>().get(Url.GET_CASHBACK_TRANSACTIONS_URL,queryParameters: params);

     // final parsedJson = commitmentsRes.data;
      if (transactionsRes.statusCode! < 400) {


        List<ContributorModel> someCommitments=[];
        List<Transaction> transactions = List<Transaction>.from(transactionsRes.data['data'].map((x) => Transaction.fromJson(x)));

        if(transactions.isNotEmpty){
          transactions.forEach((trans) {
            if(trans.reference!=null&&trans.reference!.category=='Community')

              someCommitments.add(ContributorModel(amount: trans.amount,avatar:trans.reference!.avatar ,name: trans.reference!.name,commitment: trans.reference!.commitment));


          });

        }else{
          someCommitments.clear();
        }


        return {'message': 'Commitments retrieved successfully', 'data': someCommitments};
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

  Future<List<Commitment>> getFromToUser(String action,int user) async {
    try {
      Response transactionsRes = await sl<DioClient>().get(Url.GET_CASHBACK_TRANSACTIONS_URL,queryParameters: {'action':action});

      if (transactionsRes.statusCode! < 400) {


        List<Commitment> someCommitments=[];
        List<Transaction> transactions = List<Transaction>.from(transactionsRes.data['data'].map((x) => Transaction.fromJson(x)));

        if(transactions.isNotEmpty){
          transactions.forEach((trans) {
            if(trans.reference!=null)
              {
                if(trans.reference!.commitment!=null)
                {
                  if(action=='send'&&trans.reference!.to_user_id==user){
                    someCommitments.add(trans.reference!.commitment!..categoryName=trans.reference!.category..amount=double.parse(trans.amount.toString()));

                  }
                  if(action=='rserved'&&trans.reference!.from_user_id==user){
                    someCommitments.add(trans.reference!.commitment!..categoryName=trans.reference!.category..amount=double.parse(trans.amount.toString()));

                  }

                }
              }

          });

        }else{
          someCommitments.clear();
        }



        return someCommitments;
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



  Future<Map> getReceivedProductsOfCategory(Map<String,dynamic>? params) async {
    try {
      Response ordersRes = await sl<DioClient>().get(Url.CORDERS_URL,);
      Response transactionsRes = await sl<DioClient>().get(Url.GET_CASHBACK_TRANSACTIONS_URL,queryParameters: params);

      final parsedJson = ordersRes.data;
      if (ordersRes.statusCode! < 400&&transactionsRes.statusCode! < 400) {
        List<dynamic> data = parsedJson['data'];
        List<Order> orders = data.map((json) => Order.fromJson(json)).toList();


        List<Order> someCommitments=[];
        List<Transaction> transactions = List<Transaction>.from(transactionsRes.data['data'].map((x) => Transaction.fromJson(x)));

        if(transactions.isNotEmpty){
          transactions.forEach((trans) {
            if(trans.reference!=null)
            someCommitments.addAll(orders.where((comm) => comm.productName==trans.reference!.name).toList());

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