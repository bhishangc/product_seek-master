import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/cart_model.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM CartItemModel WHERE status = "pending"')
  Stream<List<CartItemModel>> getCartItems();

  @Query(
      'SELECT * FROM CartItemModel WHERE status="pending" AND product =:product')
  Future<CartItemModel> checkExistingItem(String product);

  @update
  Future<void> updateItem(CartItemModel item);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addItemToCart(CartItemModel cartItem);

  @Query('DELETE FROM CartItemModel')
  Future<void> remoteItems();

  @delete
  Future<void> remoteItem(CartItemModel cartItem);
}
