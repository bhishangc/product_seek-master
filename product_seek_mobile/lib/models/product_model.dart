import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/category_model.dart';
import 'package:product_seek_mobile/models/store_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';

@entity
class ProductModel {
  @primaryKey
  int id;
  String title;
  String images;
  double price;
  String description;
  String warrenty;
  @ColumnInfo(name: "category_id")
  int categoryId;
  @ColumnInfo(name: "store_id")
  int storeId;

  ProductModel(this.id, this.title, this.images, this.price, this.description,
      this.categoryId, this.storeId);

  ProductModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_PRODUCT_ID];
    this.title = json[NetworkConfig.API_KEY_PRODUCT_TITLE];
    this.price = json[NetworkConfig.API_KEY_PRODUCT_PRICE].toDouble();
    this.description = json[NetworkConfig.API_KEY_PRODUCT_DESCRIPTION];
    this.warrenty = json[NetworkConfig.API_KEY_PRODUCT_WARRENTY];
    this.images = jsonEncode(json[NetworkConfig.API_KEY_PRODUCT_IMAGE]);
    try {
      this.categoryId = CategoryModel.fromJson(
              json[NetworkConfig.API_KEY_PRODUCT_CATEGORY][0])
          .id;
      this.storeId =
          StoreModel.fromJson(json[NetworkConfig.API_KEY_PRODUCT_STORE][0]).id;
    } catch (e) {
      print(e.toString());
    }
  }

  ProductModel.fromOrderJson(dynamic json) {}

  ProductModel.fromWishlistJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_PRODUCT_ID];
    this.title = json[NetworkConfig.API_KEY_PRODUCT_TITLE];
    this.price = json[NetworkConfig.API_KEY_PRODUCT_PRICE].toDouble();
    this.description = json[NetworkConfig.API_KEY_PRODUCT_DESCRIPTION];
    this.images = jsonEncode(json[NetworkConfig.API_KEY_PRODUCT_IMAGE]);
  }

  ProductModel.fromLocalJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_PRODUCT_ID];
    this.title = json[NetworkConfig.API_KEY_PRODUCT_TITLE];
    this.price = json[NetworkConfig.API_KEY_PRODUCT_PRICE].toDouble();
    this.description = json[NetworkConfig.API_KEY_PRODUCT_DESCRIPTION];
    this.images = json[NetworkConfig.API_KEY_PRODUCT_IMAGE];
    this.categoryId = json[NetworkConfig.API_KEY_PRODUCT_CATEGORY_ID];
    this.storeId = json[NetworkConfig.API_KEY_PRODUCT_STORE_ID];
  }

  Map toJson() => {
        NetworkConfig.API_KEY_PRODUCT_ID: id,
        NetworkConfig.API_KEY_PRODUCT_TITLE: title,
        NetworkConfig.API_KEY_PRODUCT_PRICE: price,
        NetworkConfig.API_KEY_PRODUCT_DESCRIPTION: description,
        NetworkConfig.API_KEY_PRODUCT_IMAGE: images,
        NetworkConfig.API_KEY_PRODUCT_CATEGORY_ID: categoryId,
        NetworkConfig.API_KEY_PRODUCT_STORE_ID: storeId,
      };
}
