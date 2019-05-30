import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/gallery_responce.dart';
import 'models/news_responce.dart';
import 'models/service_responce.dart';

class Network {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static final String _baseUrl = 'http://khouryinsurance.com';
  static final String _apiURL = _baseUrl + '/api/';
  static final String mediaURL = _baseUrl + '/storage/app/public';

  final String serviceURL = _apiURL + 'services';
  final String galleriesURL = _apiURL + 'galleries';
  final String newsURL = _apiURL + 'news';

  Future<ServiceResponce> getServices() async {
    final response = await http.get(serviceURL);
    if (response.statusCode == 200) {
      return ServiceResponce.fromJson(json.decode(response.body));
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<ServiceResponce> getServiceProducts(String id) async {
    var _subURL = _apiURL + "service/sub/$id";
    final response = await http.get(_subURL);
    if (response.statusCode == 200) {
      return ServiceResponce.fromJson(json.decode(response.body));
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<GalleryResponce> getGalleries() async {
    final response = await http.get(galleriesURL);
    if (response.statusCode == 200) {
      return GalleryResponce.fromJson(json.decode(response.body));
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<NewsResponce> getNews() async {
    final response = await http.get(newsURL);
    if (response.statusCode == 200) {
      return NewsResponce.fromJson(json.decode(response.body));
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }
}

mixin ErrorCodes {
  static const int LOGIN_FAILED = 401;
  static const int NOT_COMPLETED_SN_LOGIN = 450;
  static const int PHONENUMBER_OR_USERNAME_IS_USED = 451;
  static const int CAR_NOT_AVAILABLE = 457;
  static const int COUPON_NOT_AVAILABILE = 462;
}
