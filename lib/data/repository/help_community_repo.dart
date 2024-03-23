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
     /* Response response = await sl<DioClient>().get('${Url.SHARE_INVITATION_URL}/$id',);

      final parsedJson = response.data;*/

      final parsedJson = """
      [
  {
    "id": 1,
    "name": "John",
    "toUserPercent": 80,
    "fromUserPercent": 20
  },
  {
    "id": 2,
    "name": "Alice",
    "toUserPercent": 60,
    "fromUserPercent": 40
  },
  {
    "id": 3,
    "name": "Bob",
    "toUserPercent": 70,
    "fromUserPercent": 30
  },
  {
    "id": 4,
    "name": "Hah",
    "toUserPercent": 70,
    "fromUserPercent": 30
  }
]
      """;


        final List<dynamic> jsonData = jsonDecode(parsedJson);

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