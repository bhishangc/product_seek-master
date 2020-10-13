import 'package:product_seek_mobile/network/network_config.dart';

class ReviewModel {
  int id;
  String review;
  String username;
  int userId;

  ReviewModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_REVIEW_ID];
    this.review = json[NetworkConfig.API_KEY_REVIEW];
    this.username = json[NetworkConfig.API_KEY_REVIEW_USERNAME];
    this.userId = json[NetworkConfig.API_KEY_REVIEW_USER_ID];
  }
}
