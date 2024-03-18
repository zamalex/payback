class CategoriesResponse {
  List<Category>? categories;

  CategoriesResponse({this.categories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <Category>[];
      json['data'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
  }


}

class Category{
  int? id;
  String? name;
  String? description;
  String? image;
  String? isFeatured;
  bool isMapSelected = false;

  Category(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.isFeatured,
        this.isMapSelected=false,
     });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
     image = json['image'];
    isFeatured = json['is_featured'];

  }





}