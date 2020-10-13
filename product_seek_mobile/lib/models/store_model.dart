import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:product_seek_mobile/network/network_config.dart';

@entity
class StoreModel {
  @primaryKey
  int id;
  String name;
  String email;
  String contact;
  String address;
  String followers;
  String mapUrl;

  StoreModel(this.id, this.name, this.email, this.contact, this.address,
      this.followers, this.mapUrl);

  StoreModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_STORE_ID];
    this.name = json[NetworkConfig.API_KEY_STORE_NAME];
    this.email = json[NetworkConfig.API_KEY_STORE_EMAIL];
    this.contact = json[NetworkConfig.API_KEY_STORE_CONTACT];
    this.address = json[NetworkConfig.API_KEY_STORE_ADDRESS];
    this.followers = jsonEncode(json[NetworkConfig.API_KEY_STORE_FOLLOWERS]);
    this.mapUrl = json[NetworkConfig.API_KEY_STORE_MAP_URL];
  }
}
