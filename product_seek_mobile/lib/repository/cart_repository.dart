import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  SharedPreferences prefs;
  AppDatabase database;

  CartRepository({this.prefs, this.database});

  addItemToCart(CartItemModel cartItem) {
    database.cartDao.addItemToCart(cartItem);
  }

  removeItemToCart(CartItemModel cartItem) {
    database.cartDao.remoteItem(cartItem);
  }

  Future<void> changeQuantity(CartItemModel cartItem) =>
      database.cartDao.updateItem(cartItem);

  Stream<List<CartItemModel>> getItemsFromCart() =>
      database.cartDao.getCartItems();
}
