import 'package:payback/model/partner_model.dart';

class BranchesResponse {
  List<Branch>? branches;

  BranchesResponse({this.branches});

  factory BranchesResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? data = json['data'];
    return BranchesResponse(
      branches: data != null
          ? data.map((branchJson) => Branch.fromJson(branchJson)).toList()
          : null,
    );
  }
}

class Branch {
  int? id;
  String? name;
  int? vendorId;
  String? vendorName;
  String? vendorDescription;
  String? vendorImage;

  Partner? vendor;

  int? categoryId;
  int? countryId;
  String? countryName;

  int? cityId;
  String? cityName;

  double? locationLat;
  double? locationLng;
  String? address;

  Branch({
    this.id,
    this.name,
    this.vendorId,
    this.vendorName,
    this.vendorDescription,
    this.vendorImage,
    this.vendor,
    this.categoryId,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.locationLat,
    this.locationLng,
    this.address,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      vendorId: json['vendor_id'] != null ? json['vendor_id']['id'] : null,
      vendorName:
      json['vendor_id'] != null ? json['vendor_id']['name'] : null,
      vendorDescription: json['vendor_id'] != null
          ? json['vendor_id']['description']
          : null,
      vendorImage:
      json['vendor_id'] != null ? json['vendor_id']['image'] : null,
      vendor: json['vendor_id'] != null
          ? Partner.fromJson(json['vendor_id'])
          : null,
      categoryId: json['category_id']['id'],
      countryId:
      json['country_id'] != null ? json['country_id']['id'] : null,
      countryName:
      json['country_id'] != null ? json['country_id']['name'] : null,
      cityId: json['city_id'] != null ? json['city_id']['id'] : null,
      cityName: json['city_id'] != null ? json['city_id']['name'] : null,
      locationLat: json['location'] != null ? json['location']['lat'] : null,
      locationLng: json['location'] != null ? json['location']['lng'] : null,
      address: json['address'],
    );
  }
}
