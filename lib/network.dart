import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:kib/models/about_response.dart';

import 'models/city_response.dart';
import 'models/gallery_responce.dart';
import 'models/news_responce.dart';
import 'models/service_responce.dart';
import 'models/user_responce.dart';

class Network {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static final String baseUrl = 'http://khouryinsurance.com';
  static final String _apiURL = baseUrl + '/api/';
  static final String mediaURL = baseUrl + '/storage/app/public';
  final String loginURL = _apiURL + 'login';
  final String activateURL = _apiURL + 'user/active';
  final String registerURL = _apiURL + 'register';
  final String serviceURL = _apiURL + 'services';
  final String productURL = _apiURL + 'products';
  final String galleriesURL = _apiURL + 'galleries';
  final String newsURL = _apiURL + 'news';
  final String citiesURL = _apiURL + 'cities';
  final String aboutURL = _apiURL + 'aboutus';

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

  Future<ServiceResponce> getInsurances() async {
    final response = await http.get(productURL);
    if (response.statusCode == 200) {
      return ServiceResponce.fromJson(json.decode(response.body));
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<ServiceResponce> getInsuranceProducts(String id) async {
    var _subURL = _apiURL + "product/sub/$id";
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

  Future<UserResponse> login(String email, String password) async {
    final body = json.encode({
      'email': email,
      'password': password,
    });
    final response = await http.post(loginURL, body: body, headers: headers);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print(res);
      if (res["status"] == false) {
        throw 'error_wrong_credentials';
      } else {
        return UserResponse.fromJson(json.decode(response.body));
      }
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<UserResponse> activate(String email, String code) async {
    final body = json.encode({
      'email': email,
      'code': code,
    });
    final response = await http.post(activateURL, body: body, headers: headers);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print(res);
      if (res["status"] == false) {
        throw 'Activation Error';
      } else {
        return UserResponse.fromJson(json.decode(response.body));
      }
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<UserResponse> signUp(
    String firstName,
    String fatherName,
    String lastName,
    String email,
    String mobile,
    String password,
    String birthdate,
    String cityId,
  ) async {
    print(Platform.operatingSystem);
    final body = json.encode({
      'fname_en': firstName,
      'father_name_en': fatherName,
      'lname_en': lastName,
      'username': 'x',
      'email': email,
      'password': password,
      'birthdate': birthdate,
      'city_id': cityId,
      'mobile': mobile,
      'os': Platform.operatingSystem,
    });
    final response = await http.post(registerURL, body: body, headers: headers);
    if (response.statusCode == 200) {
      var obj = json.decode(response.body);
      print(obj);
      if (obj['status'] == true) {
        return UserResponse.fromJson(json.decode(response.body));
      } else {
        String error = "";
        List<String>.from(obj['message']).forEach((f) {
          error += f + "\n";
        });
        throw error;
      }
    } else if (response.statusCode ==
        ErrorCodes.PHONENUMBER_OR_USERNAME_IS_USED) {
      print(json.decode(response.body));
      throw 'PHONENUMBER_OR_USERNAME_IS_USED';
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

  Future<AboutResponce> getAbout() async {
    final response = await http.get(aboutURL);
    if (response.statusCode == 200) {
      return AboutResponce.fromJson(json.decode(response.body));
    } else if (response.statusCode == ErrorCodes.LOGIN_FAILED) {
      throw 'error_wrong_credentials';
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<CityResponce> getCities() async {
    final response = await http.get(citiesURL);
    if (response.statusCode == 200) {
      return CityResponce.fromJson(json.decode(response.body));
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
