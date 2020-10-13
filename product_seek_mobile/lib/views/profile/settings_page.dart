import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:product_seek_mobile/views/profile/update_password.dart';
import 'package:product_seek_mobile/views/profile/update_profile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage(
      {this.userInfo, this.profileViewModel, this.logOutCallBack});
  final UserModel userInfo;
  final ProfileViewModel profileViewModel;
  final VoidCallback logOutCallBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
          child: Container(
        child: Column(children: [
          userInfo != null ? _buildUserSettings(context) : Container(),
          _buildSettings(),
          userInfo != null ? _buildLogOutButton(context) : Container(),
        ]),
      )),
    );
  }

  Widget _buildSettings() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child:
                  Text("Terms and Conditions", style: TextStyle(fontSize: 16)),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text("Help", style: TextStyle(fontSize: 16)),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text("About", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserSettings(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePasswordPage()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.lock,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Change password", style: TextStyle(fontSize: 16))
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Edit profile", style: TextStyle(fontSize: 16))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogOutButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      child: FlatButton(
          onPressed: () {
            profileViewModel.logOut().then((value) {
              logOutCallBack();
              Navigator.pop(context);
            });
          },
          color: Theme.of(context).primaryColor,
          child: Container(
            height: 45,
            child: Center(
              child: Text("Log out",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          )),
    );
  }
}
