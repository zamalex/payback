class CategoriesResponse {
  List<Category>? categories;

  CategoriesResponse({this.categories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
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

  Category(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.isFeatured,
     });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
     image = json['image'];
    isFeatured = json['is_featured'];

  }





}