import 'package:floor/floor.dart';
import 'package:product_seek_mobile/network/network_config.dart';

@entity
class UserModel {
  @primaryKey
  int id;
  String name;
  String email;
  @ColumnInfo(name: "phone_number")
  String phoneNumber;
  String address;
  String role;

  UserModel(this.id, this.name, this.email, this.phoneNumber, this.address,
      this.role);

  UserModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_USER_ID];
    this.name = json[NetworkConfig.API_KEY_USER_NAME];
    this.email = json[NetworkConfig.API_KEY_USER_EMAIL];
    this.phoneNumber = json[NetworkConfig.API_KEY_USER_PHONE_NUMBER];
    this.address = json[NetworkConfig.API_KEY_USER_ADDRESS];
    this.role = json[NetworkConfig.API_KEY_USER_ROLE];
  }
}
