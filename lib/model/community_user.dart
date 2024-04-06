// user_model.dart

import 'package:payback/model/auth_response.dart';

import '../data/service_locator.dart';

class CommunityUser {
  final int id;
  final String name;
  final int user_id;
  final String avatar;
  final String toUserPercent;
  final String fromUserPercent;

  CommunityUser({
    required this.id,
    required this.name,
    required this.user_id,
    required this.avatar,
    required this.toUserPercent,
    required this.fromUserPercent,
  });

  factory CommunityUser.fromJson(Map<String, dynamic> json) {
    int myID = sl<AuthResponse>().data!.user!.id!;
    int userID =  int.parse(json['user_id'].toString());
    int toUserID =  int.parse(json['to_user_id'].toString());
    return CommunityUser(
      id: json['id'] as int? ?? 0,
      user_id: myID==userID?toUserID:userID,
      avatar:myID==userID?json['to_user_avatar']: json['avatar'],
      name:myID==userID?json['to_user_name'] as String? ?? '': json['name'] as String? ?? '',
      toUserPercent: json['toUserPercent'].toString(),
      fromUserPercent: json['fromUserPercent'].toString(),
    );
  }
}
