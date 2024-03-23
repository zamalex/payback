// user_model.dart

class CommunityUser {
  final int id;
  final String name;
  final int toUserPercent;
  final int fromUserPercent;

  CommunityUser({
    required this.id,
    required this.name,
    required this.toUserPercent,
    required this.fromUserPercent,
  });

  factory CommunityUser.fromJson(Map<String, dynamic> json) {
    return CommunityUser(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      toUserPercent: json['toUserPercent'] as int? ?? 0,
      fromUserPercent: json['fromUserPercent'] as int? ?? 0,
    );
  }
}
