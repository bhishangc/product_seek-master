import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/cart_model.dart';

@entity
class CheckoutModel {
  @PrimaryKey(autoGenerate: true)
  final int id;
  List<CartItemModel> prductList;
  double total;
  int userId;

  CheckoutModel(this.id, this.prductList, this.total, this.userId);

  Map toJson() {
    List<Map> products = this.prductList != null
        ? this.prductList.map((i) => i.toJson()).toList()
        : null;
    return {'products': products, 'total_amount': total, 'user_id': userId};
  }
}
