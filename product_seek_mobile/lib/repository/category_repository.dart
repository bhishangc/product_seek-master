import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/category_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepository {
  SharedPreferences prefs;
  AppDatabase database;

  CategoryRepository({this.prefs, this.database});

  Stream<CategoryModel> getCategoryInfo(int id) {
    return database.categoryDao.getCategoryFromId(id);
  }

  getCategoryInfoBackend(int id) {
    NetworkUtil()
        .get(url: NetworkEndpoints.CATEGORY_INFO + id.toString())
        .then((response) {
      if (response != null) {
        CategoryModel category = CategoryModel.fromJson(response);
        database.categoryDao.addCategory(category);
      }
    });
  }
}
