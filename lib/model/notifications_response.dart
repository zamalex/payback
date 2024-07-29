class NotificationsResponse {
  List<NotificationItem>? notifications;

  NotificationsResponse({this.notifications});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notifications = <NotificationItem>[];
      json['data'].forEach((v) {
        notifications!.add(new NotificationItem.fromJson(v));
      });
    }
  }


}

class NotificationItem {
  String? imageUrl;
  String? title;
  String? content;
  String? read;

  NotificationItem({this.imageUrl, this.title, this.content});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title']??'Notification';
    content = json['body'];
    read = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}