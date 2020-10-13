import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/product_model.dart';

@dao
abstract class ProductDao {
  @Query("SELECT * FROM ProductModel LIMIT 30")
  Stream<List<ProductModel>> getProducts();

  @Query("SELECT * FROM ProductModel where id =:id")
  Future<ProductModel> getProductById(int id);

  @Query("SELECT * FROM ProductModel WHERE category_id =:categoryId LIMIT 30")
  Stream<List<ProductModel>> getProductsByCategory(int categoryId);

  @Query("SELECT * FROM ProductModel WHERE title LIKE :name")
  Stream<List<ProductModel>> getSearchresults(String name);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addProduct(ProductModel product);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addProducts(List<ProductModel> product);

  @update
  Future<void> updateProduct(ProductModel product);

  @delete
  Future<void> removeProduct(ProductModel product);
}
