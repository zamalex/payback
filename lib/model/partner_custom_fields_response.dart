class PartnerCustomFieldsResponse {
  late int id;
  late String? name;
  late String? description;
  late List<CustomField>? customFields;

  PartnerCustomFieldsResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.customFields,
  });

  factory PartnerCustomFieldsResponse.fromJson(Map<String, dynamic> json) {
    return PartnerCustomFieldsResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      customFields: (json['custom_fields'] as List)
          .map((fieldJson) => CustomField.fromJson(fieldJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'description': description,
      'custom_fields':customFields==null?[]: customFields!.map((field) => field.toJson()).toList(),
    };
    return data;
  }
}

class CustomField {
  late int id;
  late String displayName;
  late String fieldName;
  late String component;
  late String type;
  late dynamic value;
  late String? defaultValue;
  late dynamic options;
  late bool multiple;
  late String partnerId;

  CustomField({
    required this.id,
    required this.displayName,
    required this.fieldName,
    required this.component,
    required this.type,
    required this.value,
    required this.defaultValue,
    required this.options,
    required this.multiple,
    required this.partnerId,
  });

  factory CustomField.fromJson(Map<String, dynamic> json) {
    return CustomField(
      id: json['id'],
      displayName: json['display_name'],
      fieldName: json['field_name'],
      component: json['component'],
      type: json['type'],
      value: json['value'],
      defaultValue: json['default'],
      options: json['options'],
      multiple: json['multiple'] == "1",
      partnerId: json['partner_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'display_name': displayName,
      'field_name': fieldName,
      'component': component,
      'type': type,
      'value': value,
      'default': defaultValue,
      'options': options,
      'multiple': multiple ? "1" : "0",
      'partner_id': partnerId,
    };
    return data;
  }
}
