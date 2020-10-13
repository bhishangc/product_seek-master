import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/wish_list_model.dart';
import 'package:product_seek_mobile/repository/wishlist_repository.dart';

class WishlistViewModel extends ChangeNotifier {
  final WishlistRepository wishlistRepo;

  WishlistViewModel({@required this.wishlistRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  Future<List<WishlistModel>> getWishlist(int userId) =>
      wishlistRepo.getWishlist(userId);
  Future<bool> addWishList(int productId, int userID) =>
      wishlistRepo.addWishList(productId, userID);
  Future<bool> removeWishList(WishlistModel wishlistModel) =>
      wishlistRepo.removeWishList(wishlistModel.id);
}
