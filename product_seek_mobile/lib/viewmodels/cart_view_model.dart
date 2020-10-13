import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:product_seek_mobile/repository/cart_repository.dart';

class CartViewModel extends ChangeNotifier {
  final CartRepository cartRepo;

  CartViewModel({@required this.cartRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  Future<void> changeQuantity(CartItemModel item) =>
      cartRepo.changeQuantity(item);

  addItemToCart(CartItemModel cartItem) => cartRepo.addItemToCart(cartItem);
  removeItemToCart(CartItemModel cartItem) =>
      cartRepo.removeItemToCart(cartItem);

  Stream<List<CartItemModel>> getItemsFromCart() => cartRepo.getItemsFromCart();
}
