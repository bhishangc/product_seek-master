import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/store_model.dart';

@dao
abstract class StoreDao {
  @Query('SELECT * FROM StoreModel')
  Stream<StoreModel> getStore();

  @Query('SELECT * FROM StoreModel WHERE id = :id')
  Future<StoreModel> getStoreFromId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addStore(StoreModel storeModel);
}
