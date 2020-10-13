import 'package:flutter/material.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:provider/provider.dart';

class UpdatePasswordPage extends StatefulWidget {
  UpdatePasswordPage({Key key});

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _newPasswordConfirm = TextEditingController();

  bool _isLoading = false;
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  String _serverMessage = "";
  bool once = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                      key: formKey,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            _buildOldPasswordFormField(),
                            SizedBox(
                              height: 15,
                            ),
                            _buildNewPasswordFormField(),
                            SizedBox(
                              height: 15,
                            ),
                            _buildNewConfirmPasswordFormField(),
                            SizedBox(
                              height: 5,
                            ),
                            _buildErrorMessage(),
                            SizedBox(
                              height: 30,
                            ),
                            _buildUpdateButton(profileViewModel),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.trim().length < 8)
        return 'Password must be more than or equal to 8 characters';
      else
        return null;
    } else
      return 'Please enter your password';
  }

  Widget _buildOldPasswordFormField() {
    return TextFormField(
      controller: _oldPassword,
      validator: validatePassword,
      obscureText: !_showOldPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showOldPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showOldPassword = !this._showOldPassword);
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'Old Password'),
    );
  }

  Widget _buildNewPasswordFormField() {
    return TextFormField(
      controller: _newPassword,
      validator: validatePassword,
      obscureText: !_showNewPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showNewPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showNewPassword = !this._showNewPassword);
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'New Password'),
    );
  }

  Widget _buildNewConfirmPasswordFormField() {
    return TextFormField(
      controller: _newPasswordConfirm,
      validator: (value) {
        if (_newPassword.text.trim() == value) {
          return null;
        } else {
          return "Confirm password do not match";
        }
      },
      obscureText: !_showConfirmPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showConfirmPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(
                  () => this._showConfirmPassword = !this._showConfirmPassword);
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'New Confirm Password'),
    );
  }

  Widget _buildErrorMessage() {
    return Visibility(
        visible: _serverMessage.trim().isNotEmpty,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _serverMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ));
  }

  Widget _buildUpdateButton(ProfileViewModel profileViewModel) {
    return ButtonTheme(
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
                  profileViewModel
                      .updateUserPassword(
                          userDetails.id,
                          _oldPassword.text.trim(),
                          _newPasswordConfirm.text.trim(),
                          _newPasswordConfirm.text.trim())
                      .then((value) {
                    setState(() {
                      _isLoading = false;
                    });
                    if (value) {
                      globalScaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Container(
                            child: Text("Password updated successfully")),
                        behavior: SnackBarBehavior.floating,
                      ));
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else {
                      _serverMessage = profileViewModel.getMessage();
                    }
                  });
                }
              },
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 800.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Update Profile",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
