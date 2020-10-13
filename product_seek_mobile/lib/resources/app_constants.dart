import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/user_model.dart';

const String IS_LOGGED_IN = "is_logged_in";
const String ACCESS_TOKEN = "access_token";
const String USER_ID = "user_id";

UserModel userDetails;
bool globalIsLoggedIn = false;

final GlobalKey<ScaffoldState> globalScaffoldkey =
    new GlobalKey<ScaffoldState>();
