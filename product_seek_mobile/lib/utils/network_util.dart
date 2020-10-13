import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

//Network utils for nerwork requests
class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get({
    @required String url,
  }) {
    try {
      return http
          .get(url)
          .timeout(Duration(seconds: 10))
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          final String res = response.body;
          if (res.isNotEmpty) {
            return _decoder.convert(res);
          } else {
            return true;
          }
        }
      });
    } on TimeoutException catch (tE) {
      print(tE.message.toString());
      return _decoder.convert('{"message": "Connection timed out"}');
    } on SocketException catch (sE) {
      print(sE.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> post(
      {@required String url, Map headers, body, encoding}) async {
    try {
      return await http
          .post(url, body: body, headers: headers, encoding: encoding)
          .timeout(Duration(seconds: 10))
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          final String res = response.body;
          return _decoder.convert(res);
        }
      });
    } on TimeoutException catch (tE) {
      print(tE.message.toString());
      return _decoder.convert('{"message": "Connection timed out"}');
    } on SocketException catch (sE) {
      print(sE.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> put(
      {@required String url, Map headers, body, encoding}) async {
    try {
      return await http
          .put(url, body: body, headers: headers, encoding: encoding)
          .timeout(Duration(seconds: 10))
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          final String res = response.body;
          return _decoder.convert(res);
        }
      });
    } on TimeoutException catch (tE) {
      print(tE.message.toString());
      return _decoder.convert('{"message": "Connection timed out"}');
    } on SocketException catch (sE) {
      print(sE.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
