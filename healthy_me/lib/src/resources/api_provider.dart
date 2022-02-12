import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:healthy_me/src/model/api/profile_model.dart';
import 'package:healthy_me/src/model/event_bus/http_result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  static Duration durationTimeout = new Duration(seconds: 30);
  static String baseUrl = "https://icoders.uz/api/healthyme/";

  static Future<HttpResult> postRequest(url, body, head) async {
    print(url);
    print(body);
    dynamic headers = await _getReqHeader();

    print(headers);
    try {
      http.Response response = await http
          .post(
        Uri.parse(url),
        headers: head ? headers : null,
        body: body,
      )
          .timeout(durationTimeout);
      print(response.body);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        status: -1,
        result: {},
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        status: -1,
        result: {},
      );
    }
  }

  static Future<HttpResult> getRequest(url) async {
    print(url);
    final dynamic headers = await _getReqHeader();
    try {
      http.Response response = await http
          .get(
        Uri.parse(url),
        headers: headers,
      )
          .timeout(durationTimeout);
      print(response.body);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        status: -1,
        result: {},
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        status: -1,
        result: {},
      );
    }
  }

  static HttpResult _result(response) {
    int status = response.statusCode ?? 404;

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var result;
      result = json.decode(utf8.decode(response.bodyBytes));
      return HttpResult(
        isSuccess: true,
        status: status,
        result: result,
      );
    } else {
      try {
        var result;
        result = json.decode(utf8.decode(response.bodyBytes));
        return HttpResult(
          isSuccess: false,
          status: status,
          result: result,
        );
      } catch (_) {
        return HttpResult(
          isSuccess: false,
          status: status,
          result: {
            "msg": "Server error, please try again",
          },
        );
      }
    }
  }

  static _getReqHeader() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') == null) {
      return {
        "Accept": "application/json",
      };
    } else {
      return {
        "Accept": "application/json",
        "Authorization": "Bearer " + (prefs.getString('token') ?? ""),
      };
    }
  }

  /// Register api
  Future<HttpResult> fetchRegister(
      String username,
      String password,
      String phone,
      ) async {
    String url = baseUrl + 'register';

    final data = {
      "username": username,
      "password": password,
      "phone": phone,
    };
    return await postRequest(url, data, false);
  }

  /// Login api
  Future<HttpResult> fetchLogin(
      String username,
      String password,
      ) async {
    String url = baseUrl + 'login';

    final data = {
      "username": username,
      "password": password,
    };
    return await postRequest(url, data, false);
  }

  /// Accept user
  Future<HttpResult> fetchAcceptUser(
      String username,
      String smsCode,
      ) async {
    String url = baseUrl + 'register-accepted';

    final data = {
      "username": username,
      "sms_code": smsCode,
    };
    return await postRequest(url, data, false);
  }

  /// Me
  Future<HttpResult> fetchMe() async {
    String url = baseUrl + 'me';
    return await getRequest(url);
  }

  /// Update Profile
  Future<HttpResult> fetchUpdateProfile(
      ProfileData info,
      ) async {
    String url = baseUrl + 'profil';
    String birthFormat = info.birthDate.year.toString() +
        "-" +
        info.birthDate.month.toString() +
        "-" +
        info.birthDate.day.toString();
    final data = {
      "full_name": info.fullName,
      "phone": info.phone,
      "gender": info.gender,
      "birth_date": birthFormat,
      "city": info.city,
      "region": info.region,
    };
    return await postRequest(url, data, true);
  }
}