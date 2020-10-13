import 'dart:async';

import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

class LoginRepository {
  SharedPreferences prefs;
  AppDatabase database;

  LoginRepository({this.prefs, this.database});
  var _isSuccessfulLogin = StreamController<bool>.broadcast();

  String _serverMessage = "";

  register({
    @required String name,
    @required String email,
    @required String password,
    @required String confirmPassword,
    @required String address,
    @required String number,
  }) {
    _serverMessage = "";
    NetworkUtil().post(url: NetworkEndpoints.REGISTER_API, body: {
      NetworkConfig.API_KEY_USER_NAME: name,
      NetworkConfig.API_KEY_USER_EMAIL: email,
      NetworkConfig.API_KEY_USER_PASSWORD: password,
      NetworkConfig.API_KEY_USER_PASSWORD_CONFIRMATION: confirmPassword,
      NetworkConfig.API_KEY_USER_ADDRESS: address,
      NetworkConfig.API_KEY_USER_ROLE: "user",
      NetworkConfig.API_KEY_USER_PHONE_NUMBER: number,
    }).then((response) async {
      if (response.toString().contains("access_token")) {
        UserModel userModel = UserModel.fromJson(response["user"]);
        database.userDao.addUserData(userModel);
        userDetails = userModel;
        await prefs.setBool(IS_LOGGED_IN, true);
        await prefs.setString(ACCESS_TOKEN, response["access_token"]);
        await prefs.setInt(USER_ID, userModel.id);
        _isSuccessfulLogin.add(true);
        globalIsLoggedIn = true;
      } else {
        _serverMessage = response["message"];
        globalIsLoggedIn = false;
        await prefs.setBool(IS_LOGGED_IN, false);
        _isSuccessfulLogin.add(false);
      }
    });
  }

  login(
      {@required String email,
      @required String password,
      @required bool rememberMe}) {
    _serverMessage = "";
    NetworkUtil().post(url: NetworkEndpoints.LOGIN_API, body: {
      NetworkConfig.API_KEY_USER_EMAIL: email,
      NetworkConfig.API_KEY_USER_PASSWORD: password
    }).then((response) async {
      if (response.toString().contains("access_token")) {
        UserModel userModel = UserModel.fromJson(response["user"]);
        userDetails = userModel;
        if (rememberMe) {
          database.userDao.addUserData(userModel);
          await prefs.setBool(IS_LOGGED_IN, true);
          await prefs.setString(ACCESS_TOKEN, response["access_token"]);
          await prefs.setInt(USER_ID, userModel.id);
        }
        globalIsLoggedIn = true;
        _isSuccessfulLogin.add(true);
      } else {
        _serverMessage = response["message"];
        globalIsLoggedIn = false;
        await prefs.setBool(IS_LOGGED_IN, false);
        _isSuccessfulLogin.add(false);
      }
    });
  }

  Future<String> resetPassword(String email) {
    return NetworkUtil().post(url: NetworkEndpoints.RESET_PASSWORD_API, body: {
      NetworkConfig.API_KEY_USER_EMAIL: email,
    }).then((response) async {
      return (response["message"]);
    });
  }

  Future<bool> isLoggedIn() async {
    if (prefs.containsKey(IS_LOGGED_IN)) {
      return prefs.getBool(IS_LOGGED_IN);
    } else
      return false;
  }

  Stream<bool> getLoginResponse() {
    return _isSuccessfulLogin.stream;
  }

  logout() async {
    prefs.clear();
    userDetails = null;
    globalIsLoggedIn = false;
    database.userDao.remoteItems();
    database.cartDao.remoteItems();
  }

  getErrorMessage() {
    return _serverMessage;
  }
}
