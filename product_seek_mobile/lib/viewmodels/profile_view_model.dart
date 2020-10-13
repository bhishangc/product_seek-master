import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/repository/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository profileRepo;

  ProfileViewModel({@required this.profileRepo});
  var _updateResponseController = StreamController<bool>.broadcast();

  init() async {
    await _refreshAllStates();
    _listenUpdateResponse();
  }

  _refreshAllStates() async {
    notifyListeners();
  }

  Future<UserModel> getUserData() => profileRepo.getUserInfo();

  Future<void> logOut() => profileRepo.logOut();

  postFeedback(String feedback, int userId) =>
      profileRepo.postFeedback(feedback, userId);

  updateUser(int userId, String name, String email, String address,
      String phone, String password) async {
    profileRepo.updateUser(userId, name, email, address, phone, password);
    await _refreshAllStates();
  }

  Future<bool> updateUserPassword(int userId, String oldPassword,
          String newPassword, String newPasswordConfirmed) =>
      profileRepo.updateUserPassword(
          userId, oldPassword, newPassword, newPasswordConfirmed);

  void _listenUpdateResponse() {
    profileRepo.getUpdateResponse().listen((isSuccessfulLogin) {
      if (isSuccessfulLogin) {
        _updateResponseController.add(true);
      } else {
        _updateResponseController.add(false);
      }
    });
  }

  Stream<bool> getUpdateResponse() => _updateResponseController.stream;

  String getMessage() {
    return profileRepo.getErrorMessage();
  }
}
