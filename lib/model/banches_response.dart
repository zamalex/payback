class BranchesResponse {
  List<Branch>? branches;

  BranchesResponse({this.branches});

  BranchesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      branches = <Branch>[];
      json['data'].forEach((v) {
        branches!.add(new Branch.fromJson(v));
      });
    }
  }

}

class Branch {
  int? id;
  String? name;
  Location? location;
  String? cityId;
  String? countryId;
  String? vendorId;
  String? address;
  String? createdAt;
  String? updatedAt;

  Branch(
      {this.id,
        this.name,
        this.location,
        this.cityId,
        this.countryId,
        this.vendorId,
        this.address,
        this.createdAt,
        this.updatedAt});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    cityId = json['city_id'];
    countryId = json['country_id'];
    vendorId = json['vendor_id'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }


}