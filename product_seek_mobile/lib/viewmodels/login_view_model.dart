import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:product_seek_mobile/repository/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository loginRepo;

  LoginViewModel({@required this.loginRepo});
  var _loginResponseController = StreamController<bool>.broadcast();
  bool isLoggedIn;

  init() async {
    await _refreshAllStates();

    _listenLoginResponse();
  }

  _refreshAllStates() async {
    isLoggedIn = await loginRepo.isLoggedIn();
    notifyListeners();
  }

  login(
      {@required String email,
      @required String password,
      @required bool rememberMe}) async {
    await loginRepo.login(
        email: email, password: password, rememberMe: rememberMe);
    await _refreshAllStates();
  }

  register(
      {@required String name,
      @required String email,
      @required String password,
      @required String confirmPassword,
      @required String address,
      @required String number}) async {
    await loginRepo.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        address: address,
        number: number);
    await _refreshAllStates();
  }

  Future<String> resetPassword(String email) => loginRepo.resetPassword(email);

  logout() async {
    await loginRepo.logout();
    await _refreshAllStates();
  }

  String getMessage() {
    return loginRepo.getErrorMessage();
  }

  void _listenLoginResponse() {
    loginRepo.getLoginResponse().listen((isSuccessfulLogin) {
      if (isSuccessfulLogin) {
        _loginResponseController.add(true);
      } else {
        _loginResponseController.add(false);
      }
    });
  }

  Stream<bool> getLoginResponse() => _loginResponseController.stream;
}
