import 'dart:async';

import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  SharedPreferences prefs;
  AppDatabase database;

  ProfileRepository({this.prefs, this.database});

  var _isSuccessfulUpdate = StreamController<bool>.broadcast();
  String _serverMessage = "";

  Future<UserModel> getUserInfo() {
    return database.userDao
        .getUserDetail(prefs.containsKey(USER_ID) ? prefs.getInt(USER_ID) : 0);
  }

  Future<void> logOut() async {
    database.cartDao.remoteItems();
    database.userDao.remoteItems();
    userDetails = null;
    globalIsLoggedIn = false;
    await prefs.clear();
  }

  postFeedback(String feedback, int userId) {
    NetworkUtil().post(url: NetworkEndpoints.FEEDBACK_API, body: {
      NetworkConfig.API_KEY_FEEDBACK: feedback,
      NetworkConfig.API_KEY_FEEDBACK_USER_ID: userId.toString()
    });
  }

  updateUser(int userId, String name, String email, String address,
      String phone, String password) {
    return NetworkUtil().put(
        url: NetworkEndpoints.PROFILE_UPDATE_API + userId.toString(),
        body: {
          NetworkConfig.API_KEY_USER_NAME: name,
          NetworkConfig.API_KEY_USER_EMAIL: email,
          NetworkConfig.API_KEY_USER_PASSWORD: password,
          NetworkConfig.API_KEY_USER_ADDRESS: address,
          NetworkConfig.API_KEY_USER_PHONE_NUMBER: phone,
        }).then((response) async {
      if (response.toString().contains("access_token")) {
        UserModel userModel = UserModel.fromJson(response["user"]);
        userDetails = userModel;
        if (prefs.getBool(IS_LOGGED_IN)) {
          database.userDao.addUserData(userModel);
        }
        _isSuccessfulUpdate.add(true);
      } else {
        _serverMessage = response["message"];
        _isSuccessfulUpdate.add(false);
      }
    });
  }

  Future<bool> updateUserPassword(int userId, String oldPassword,
          String newPassword, String newPasswordConfirmed) =>
      NetworkUtil().put(
          url: NetworkEndpoints.PASSWORD_UPDATE_API + userId.toString(),
          body: {
            NetworkConfig.API_KEY_USER_OLD_PASSWORD: oldPassword,
            NetworkConfig.API_KEY_USER_NEW_PASSWORD: newPassword,
            NetworkConfig.API_KEY_USER_NEW_PASSWORD_CONFIRMATION:
                newPasswordConfirmed,
          }).then((response) {
        if (response.toString().contains("access_token")) {
          UserModel userModel = UserModel.fromJson(response["user"]);
          userDetails = userModel;
          if (prefs.getBool(IS_LOGGED_IN)) {
            database.userDao.addUserData(userModel);
          }
          return true;
        } else {
          _serverMessage = response["message"];
          return false;
        }
      });

  getErrorMessage() {
    return _serverMessage;
  }

  Stream<bool> getUpdateResponse() {
    return _isSuccessfulUpdate.stream;
  }
}
