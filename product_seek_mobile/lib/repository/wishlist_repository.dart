import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/wish_list_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistRepository {
  SharedPreferences prefs;
  AppDatabase database;

  WishlistRepository({this.prefs, this.database});

  Future<List<WishlistModel>> getWishlist(int userId) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.WISHLIST_API + userId.toString())
        .then((response) {
      if (response != null) {
        List<WishlistModel> wishlistModels;
        wishlistModels =
            (response as List).map((i) => WishlistModel.fromJson(i)).toList();
        return wishlistModels;
      } else {
        print("Could not fetch product data");
      }
    });
  }

  Future<bool> addWishList(int productId, int userId) {
    return NetworkUtil().post(url: NetworkEndpoints.ADD_WISHLIST_API, body: {
      NetworkConfig.API_KEY_WISHLIST_PRODUCT_ID: productId.toString(),
      NetworkConfig.API_KEY_WISHLIST_USER_ID: userId.toString()
    }).then((response) {
      return true;
    });
  }

  Future<bool> removeWishList(int id) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.REMOVE_WISHLIST_API + id.toString())
        .then((response) {
      return true;
    });
  }
}
