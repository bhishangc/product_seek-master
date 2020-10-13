import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/models/review_model.dart';
import 'package:product_seek_mobile/models/store_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreRepository {
  SharedPreferences prefs;
  AppDatabase database;

  StoreRepository({this.prefs, this.database});

  Future<void> followStore(int userId, int storeId) {
    return NetworkUtil().post(
        url: NetworkEndpoints.FOLLOW_STORE,
        body: {"user_id": userId.toString(), "store_id": storeId.toString()});
  }

  Future<void> unfollowStore(int userId, int storeId) {
    return NetworkUtil().post(
        url: NetworkEndpoints.UNFOLLOW_STORE,
        body: {"user_id": userId.toString(), "store_id": storeId.toString()});
  }

  Future<StoreModel> getStoreInfo(int id) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.STORE_INFO + id.toString())
        .then((response) {
      if (response != null) {
        StoreModel store = StoreModel.fromJson(response);
        return store;
      }
    });
  }

  Future<List<StoreModel>> getFollowedStore(int userId) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.FOLLOWED_STORE + userId.toString())
        .then((response) {
      if (response != null) {
        List<StoreModel> storeModel;
        storeModel =
            (response as List).map((i) => StoreModel.fromJson(i)).toList();
        return storeModel;
      }
    });
  }

  Future<List<ProductModel>> getStoreItems(int id) => NetworkUtil()
          .get(url: NetworkEndpoints.STORE_PRODUCTS + id.toString())
          .then((response) async {
        if (response != null) {
          List<ProductModel> productModels;
          productModels =
              (response as List).map((i) => ProductModel.fromJson(i)).toList();
          return productModels;
        } else {
          print("Could not fetch product data");
        }
      });

  Future<List<ReviewModel>> getReviews(int productId) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.PRODUCT_REVIEW_API + productId.toString())
        .then((response) {
      if (response != null) {
        List<ReviewModel> reviewModels;
        reviewModels =
            (response as List).map((i) => ReviewModel.fromJson(i)).toList();
        return reviewModels;
      } else {
        print("Could not fetch product data");
      }
    });
  }
}
