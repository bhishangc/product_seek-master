import 'package:flutter/material.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  UpdateProfilePage({Key key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isLoading = false;
  bool _showPassword = false;
  String _serverMessage = "";
  bool once = true;

  @override
  void initState() {
    super.initState();
    _name.text = userDetails.name;
    _email.text = userDetails.email;
    _address.text = userDetails.address;
    _phone.text = userDetails.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    profileViewModel.getUpdateResponse().listen((isSuccessfulUpdate) {
      setState(() {
        _isLoading = false;
        if (isSuccessfulUpdate) {
          if (once) {
            once = false;
            globalScaffoldkey.currentState.showSnackBar(SnackBar(
              content: Container(child: Text("Profile updated successfully")),
              behavior: SnackBarBehavior.floating,
            ));
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        } else {
          _serverMessage = profileViewModel.getMessage();
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
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
                            _buildNameFormField(),
                            SizedBox(
                              height: 15,
                            ),
                            _buildEmailFormField(),
                            SizedBox(
                              height: 15,
                            ),
                            _buildPhoneFormField(),
                            SizedBox(
                              height: 15,
                            ),
                            _buildAddressFormField(),
                            SizedBox(
                              height: 15,
                            ),
                            _buildPasswordFormField(),
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

  String validatePhone(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter phone number';
    } else if (value.trim().length != 10) {
      return 'Please enter valid phone number. Number must be of 10 digit';
    } else {
      return null;
    }
  }

  String validateAddress(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter your current address';
    } else if (value.trim().length < 6) {
      return 'Please enter valid full address.';
    } else {
      return null;
    }
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

  String validatePassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.trim().length < 8)
        return 'Password must be more than or equal to 8 characters';
      else
        return null;
    } else
      return 'Please enter your password';
  }

  Widget _buildNameFormField() {
    return TextFormField(
      controller: _name,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
          labelText: 'Full Name'),
    );
  }

  Widget _buildEmailFormField() {
    return TextFormField(
      enabled: false,
      readOnly: true,
      controller: _email,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(),
          labelText: 'Email'),
    );
  }

  Widget _buildAddressFormField() {
    return TextFormField(
      controller: _address,
      validator: validateAddress,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          border: OutlineInputBorder(),
          labelText: 'Address'),
    );
  }

  Widget _buildPhoneFormField() {
    return TextFormField(
      controller: _phone,
      validator: validatePhone,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(),
          labelText: 'Phone Number'),
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      controller: _password,
      validator: validatePassword,
      obscureText: !_showPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showPassword = !this._showPassword);
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'Password'),
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
                  profileViewModel.updateUser(
                      userDetails.id,
                      _name.text.trim(),
                      _email.text.trim(),
                      _address.text.trim(),
                      _phone.text.trim(),
                      _password.text.trim());
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
