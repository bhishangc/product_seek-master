import 'dart:async';

import 'package:floor/floor.dart';
import 'package:product_seek_mobile/database/dao/cart_dao.dart';
import 'package:product_seek_mobile/database/dao/category_dao.dart';
import 'package:product_seek_mobile/database/dao/product_dao.dart';
import 'package:product_seek_mobile/database/dao/store_dao.dart';
import 'package:product_seek_mobile/database/dao/user_dao.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:product_seek_mobile/models/category_model.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/models/store_model.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

//Database class
@Database(version: 1, entities: [
  UserModel,
  ProductModel,
  StoreModel,
  CategoryModel,
  CartItemModel,
])

//Dao for the appp
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  ProductDao get productDao;
  CategoryDao get categoryDao;
  StoreDao get storeDao;
  CartDao get cartDao;
}

//flutter packages pub run build_runner build
