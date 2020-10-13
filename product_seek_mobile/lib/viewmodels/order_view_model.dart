import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/order_model.dart';
import 'package:product_seek_mobile/models/review_model.dart';
import 'package:product_seek_mobile/repository/order_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository orderRepo;

  OrderViewModel({@required this.orderRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() async {
    notifyListeners();
  }

  Future<List<OrderModel>> getOrders(int id) => orderRepo.getOrders(id);
  Future<List<OrderModel>> getDeliveredOrders(int id) =>
      orderRepo.getDeliveredOrders(id);

  Future<List<OrderModel>> getReturnedOrder(int id) =>
      orderRepo.getReturnedOrder(id);

  Future<bool> cancelOrder(int orderId) => orderRepo.cancelOrder(orderId);
  Future<void> returnOrder(int orderId, String returnNote) =>
      orderRepo.returnOrder(orderId, returnNote);

  Future<bool> reviewProduct(int userId, int productId, String review) =>
      orderRepo.reviewProduct(userId, productId, review);

  Future<List<ReviewModel>> getUserReview(int userId, int productId) =>
      orderRepo.getUserReview(userId, productId);
}
