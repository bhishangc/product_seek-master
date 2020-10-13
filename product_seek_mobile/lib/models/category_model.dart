import 'package:floor/floor.dart';

@entity
class CategoryModel {
  @primaryKey
  int id;
  String name;
  CategoryModel(
    this.id,
    this.name,
  );

  CategoryModel.fromJson(dynamic json) {
    this.id = json["id"];
    this.name = json["name"];
  }
}
