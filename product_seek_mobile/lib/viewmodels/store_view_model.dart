import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/review_model.dart';
import 'package:product_seek_mobile/models/store_model.dart';
import 'package:product_seek_mobile/repository/store_repository.dart';

class StoreViewModel extends ChangeNotifier {
  final StoreRepository storeRepo;

  StoreViewModel({@required this.storeRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  getStoreInfo(int id) => storeRepo.getStoreInfo(id);

  getStoreItems(int id) => storeRepo.getStoreItems(id);

  Future<List<StoreModel>> getFollowedStore(int userId) =>
      storeRepo.getFollowedStore(userId);

  Future<void> followStore(int userId, int storeId) =>
      storeRepo.followStore(userId, storeId);

  Future<void> unfollowStore(int userId, int storeId) =>
      storeRepo.unfollowStore(userId, storeId);

  Future<List<ReviewModel>> getReviews(int productId) =>
      storeRepo.getReviews(productId);
}
