import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';

class OrderModel {
  int id;
  String orderNumber;
  ProductModel product;
  String status;
  int quantity;
  double totalPrice;
  bool returnable = false;

  OrderModel(this.id, this.orderNumber, this.product, this.status,
      this.quantity, this.totalPrice, this.returnable);

  OrderModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_ORDER_ID];
    this.orderNumber = json[NetworkConfig.API_KEY_ORDER_NUMBER];
    this.product =
        ProductModel.fromJson(json[NetworkConfig.API_KEY_ORDER_PRODUCTS]);
    this.status = json[NetworkConfig.API_KEY_ORDER_STATUS];
    this.quantity = json[NetworkConfig.API_KEY_ORDER_QUANTITY];
    this.totalPrice = json[NetworkConfig.API_KEY_ORDER_TOTAL].toDouble();
    if (json.toString().contains("returnable")) {
      this.returnable = json[NetworkConfig.API_KEY_ORDER_RETURNABLE];
    }
  }
}
