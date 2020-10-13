import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';

@entity
class WishlistModel {
  @PrimaryKey(autoGenerate: true)
  int id;
  ProductModel product;
  @ColumnInfo(name: "user_id")
  int userId;

  WishlistModel(this.id, this.product, this.userId);

  WishlistModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_WISHLIST_ID];
    this.product = ProductModel.fromWishlistJson(
        json[NetworkConfig.API_KEY_WISHLIST_PRODUCT]);
    this.userId = json[NetworkConfig.API_KEY_WISHLIST_USER_ID];
  }
}
