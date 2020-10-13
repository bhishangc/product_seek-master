import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:product_seek_mobile/app/app.dart';
import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/repository/cart_repository.dart';
import 'package:product_seek_mobile/repository/category_repository.dart';
import 'package:product_seek_mobile/repository/checkout_repository.dart';
import 'package:product_seek_mobile/repository/login_repository.dart';
import 'package:product_seek_mobile/repository/order_repository.dart';
import 'package:product_seek_mobile/repository/product_repository.dart';
import 'package:product_seek_mobile/repository/profile_repository.dart';
import 'package:product_seek_mobile/repository/store_repository.dart';
import 'package:product_seek_mobile/repository/wishlist_repository.dart';
import 'package:product_seek_mobile/viewmodels/cart_view_model.dart';
import 'package:product_seek_mobile/viewmodels/category_view_model.dart';
import 'package:product_seek_mobile/viewmodels/checkout_view_model.dart';
import 'package:product_seek_mobile/viewmodels/login_view_model.dart';
import 'package:product_seek_mobile/viewmodels/order_view_model.dart';
import 'package:product_seek_mobile/viewmodels/product_view_model.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:product_seek_mobile/viewmodels/store_view_model.dart';
import 'package:product_seek_mobile/viewmodels/wishlist_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



//Main method of the app
void main() async {
  //Initializes stetho for debug
  Stetho.initialize();

  //Initializes app database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final preferences = await SharedPreferences.getInstance();

  //Initializes all required viewmodels
  final loginViewModel = LoginViewModel(
      loginRepo: LoginRepository(prefs: preferences, database: database));
  loginViewModel.init();

  final profileViewModel = ProfileViewModel(
      profileRepo: ProfileRepository(prefs: preferences, database: database));
  profileViewModel.init();

  final productViewModel = ProductViewModel(
      productRepo: ProductRepository(prefs: preferences, database: database));
  productViewModel.init();

  final cartViewModel = CartViewModel(
      cartRepo: CartRepository(prefs: preferences, database: database));
  cartViewModel.init();

  final checkoutViewModel = CheckoutViewModel(
      checkoutRepo: CheckoutRepository(prefs: preferences, database: database));
  checkoutViewModel.init();

  final categoryViewModel = CategoryViewModel(
      categoryRepo: CategoryRepository(prefs: preferences, database: database));
  categoryViewModel.init();

  final storeViewModel = StoreViewModel(
      storeRepo: StoreRepository(prefs: preferences, database: database));
  storeViewModel.init();

  final wishlistViewModel = WishlistViewModel(
      wishlistRepo: WishlistRepository(prefs: preferences, database: database));
  wishlistViewModel.init();

  final orderViewModel = OrderViewModel(
      orderRepo: OrderRepository(prefs: preferences, database: database));
  orderViewModel.init();

  //Runs app with multiple providers
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginViewModel>.value(value: loginViewModel),
      ChangeNotifierProvider<ProfileViewModel>.value(value: profileViewModel),
      ChangeNotifierProvider<ProductViewModel>.value(value: productViewModel),
      ChangeNotifierProvider<CartViewModel>.value(value: cartViewModel),
      ChangeNotifierProvider<CheckoutViewModel>.value(value: checkoutViewModel),
      ChangeNotifierProvider<CategoryViewModel>.value(value: categoryViewModel),
      ChangeNotifierProvider<StoreViewModel>.value(value: storeViewModel),
      ChangeNotifierProvider<WishlistViewModel>.value(value: wishlistViewModel),
      ChangeNotifierProvider<OrderViewModel>.value(value: orderViewModel),
    ],
    child: App(),
  ));
}
