class SettingsResponse {
  List<Setting>? data;

  SettingsResponse({this.data,});

  SettingsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Setting>[];
      json['data'].forEach((v) {
        data!.add(new Setting.fromJson(v));
      });
    }
    }
}

class Setting {
  int? id;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  Setting({this.id, this.key, this.value, this.createdAt, this.updatedAt});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

