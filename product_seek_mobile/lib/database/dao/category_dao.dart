import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/category_model.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM CategoryModel')
  Stream<CategoryModel> getCategory();

  @Query('SELECT * FROM CategoryModel WHERE id = :id')
  Stream<CategoryModel> getCategoryFromId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addCategory(CategoryModel categoryModel);
}
