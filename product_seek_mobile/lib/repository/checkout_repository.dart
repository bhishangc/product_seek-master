import 'dart:convert';

import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutRepository {
  SharedPreferences prefs;
  AppDatabase database;

  CheckoutRepository({this.prefs, this.database});

  Future<void> orderItems(CheckoutModel checkoutItems) {
    List<Map> products = checkoutItems.prductList != null
        ? checkoutItems.prductList.map((i) => i.toJson()).toList()
        : null;
    return NetworkUtil().post(url: NetworkEndpoints.ADD_ORDERS_API, body: {
      "user_id": checkoutItems.userId.toString(),
      "total_amount": checkoutItems.total.toString(),
      "products": jsonEncode(products)
    });
  }

  clearCart() => database.cartDao.remoteItems();
}
