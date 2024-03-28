import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:payback/model/community_user.dart';
import 'package:payback/model/share_details_response.dart';

import '../../helpers/dio_error_helper.dart';
import '../../model/partner_model.dart';
import '../http/dio_client.dart';
import '../http/urls.dart';
import '../service_locator.dart';

class HelpCommunityRepository{



  Future<Map<String, dynamic>> getHelpCommunityUsersList() async {
    try {
      Response response = await sl<DioClient>().get('${Url.GET_HELP_COMUNITY_URL}',);

      final parsedJson = response.data;




        final List<dynamic> jsonData = parsedJson['data'];

        return {'data':jsonData.map((json) => CommunityUser.fromJson(json)).toList()};


    } catch (e) {
      if (e is DioError) {
        return {'message': e.message};
      } else {
        return {'message': 'Unknown error'};
      }
    }
  }
}