// user_model.dart

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
    return CommunityUser(
      id: json['id'] as int? ?? 0,
      user_id: int.parse(json['user_id'].toString()),
      avatar: json['avatar'],
      name: json['name'] as String? ?? '',
      toUserPercent: json['toUserPercent'].toString(),
      fromUserPercent: json['fromUserPercent'].toString(),
    );
  }
}
