import 'package:flutter/material.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  String _serverMessage = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: 'Email'),
                      ),
                      Visibility(
                          visible: _serverMessage.trim().isNotEmpty,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _serverMessage,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonTheme(
                        height: 45,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          onPressed: _isLoading
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                      _serverMessage = "";
                                    });
                                    loginViewModel
                                        .resetPassword(_email.text.trim())
                                        .then((message) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      _serverMessage = message;
                                      if (_serverMessage ==
                                          "We have emailed your password reset link!") {
                                        globalScaffoldkey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Container(
                                              child: Text(
                                                  "Password reset link has been sent to your mail.")),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      }
                                    });
                                  }
                                },
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 800.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Request password reset",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.trim().isNotEmpty) {
      if (!regex.hasMatch(value.trim()))
        return 'Please enter valid email';
      else
        return null;
    } else
      return 'Please enter your Email';
  }
}
