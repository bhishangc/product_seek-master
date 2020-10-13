import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/order_model.dart';
import 'package:product_seek_mobile/models/review_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  SharedPreferences prefs;
  AppDatabase database;

  OrderRepository({this.prefs, this.database});

  Future<List<OrderModel>> getOrders(int id) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.USER_ORDERS_API + id.toString())
        .then((response) {
      if (response != null) {
        List<OrderModel> orderModel;
        orderModel =
            (response as List).map((i) => OrderModel.fromJson(i)).toList();
        return orderModel;
      } else {
        print("Could not fetch product data");
      }
    });
  }

  Future<List<OrderModel>> getDeliveredOrders(int id) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.USER_DELIVERED_ORDERS_API + id.toString())
        .then((response) {
      if (response != null) {
        List<OrderModel> orderModel;
        orderModel =
            (response as List).map((i) => OrderModel.fromJson(i)).toList();
        return orderModel;
      } else {
        print("Could not fetch product data");
      }
    });
  }

  Future<List<OrderModel>> getReturnedOrder(int id) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.USER_DELIVERED_ORDERS_API + id.toString())
        .then((response) {
      if (response != null) {
        List<OrderModel> orderModel;
        orderModel =
            (response as List).map((i) => OrderModel.fromJson(i)).toList();
        return orderModel;
      } else {
        print("Could not fetch product data");
      }
    });
  }

  Future<bool> reviewProduct(int userId, int productId, String review) {
    return NetworkUtil().post(url: NetworkEndpoints.REVIEW_API, body: {
      NetworkConfig.API_KEY_WISHLIST_USER_ID: userId.toString(),
      NetworkConfig.API_KEY_WISHLIST_PRODUCT_ID: productId.toString(),
      NetworkConfig.API_KEY_REVIEW: review
    }).then((response) {
      return true;
    });
  }

  Future<bool> cancelOrder(int orderId) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.CANCEL_ORDERS_API + orderId.toString())
        .then((response) {
      return true;
    });
  }

  Future<void> returnOrder(int orderId, String returnNote) => NetworkUtil().put(
      url: NetworkEndpoints.RETURN_ORDERS_API + orderId.toString(),
      body: {NetworkConfig.API_KEY_RETURN_ORDER_BODY: returnNote});

  Future<List<ReviewModel>> getUserReview(int userId, int productId) =>
      NetworkUtil().post(url: NetworkEndpoints.USER_PRODUCT_REVIEW_API, body: {
        NetworkConfig.API_KEY_REVIEW_USER_ID: userId.toString(),
        NetworkConfig.API_KEY_REVIEW_PRODUCT_ID: productId.toString()
      }).then((response) {
        if (response != null) {
          List<ReviewModel> reviewModel;
          reviewModel =
              (response as List).map((i) => ReviewModel.fromJson(i)).toList();
          return reviewModel;
        } else {
          print("Could not fetch product data");
        }
      });
}
