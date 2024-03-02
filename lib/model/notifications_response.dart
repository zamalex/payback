class NotificationsResponse {
  List<NotificationItem>? notifications;

  NotificationsResponse({this.notifications});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <NotificationItem>[];
      json['notifications'].forEach((v) {
        notifications!.add(new NotificationItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationItem {
  String? imageUrl;
  String? title;
  String? content;

  NotificationItem({this.imageUrl, this.title, this.content});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}