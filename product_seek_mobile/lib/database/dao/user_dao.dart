import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/user_model.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM UserModel WHERE id = :id')
  Future<UserModel> getUserDetail(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addUserData(UserModel userModel);

  @Query('DELETE FROM UserModel')
  Future<void> remoteItems();
}
