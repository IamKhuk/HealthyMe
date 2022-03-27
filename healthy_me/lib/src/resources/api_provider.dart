import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:healthy_me/src/model/api/profile_model.dart';
import 'package:healthy_me/src/model/event_bus/http_result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

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
    String email,
  ) async {
    String url = baseUrl + 'register';

    final data = {
      "username": username,
      "password": password,
      "email": email,
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

  /// Get Me
  Future<HttpResult> fetchMe() async {
    String url = baseUrl + 'me';
    return await getRequest(url);
  }

  /// Update Profile
  Future<HttpResult> fetchUpdateProfile(
    ProfileData info,
  ) async {
    String url = baseUrl + 'profil/';
    String birthFormat = info.birthDate.year.toString() +
        "-" +
        info.birthDate.month.toString() +
        "-" +
        info.birthDate.day.toString();
    final data = {
      "fullname": info.fullName,
      "username": info.username,
      "email": info.email,
      "phone": info.phone,
      "gender": info.gender,
      "birth_date": birthFormat,
      "region": info.region.id.toString(),
      "city": info.city.id.toString(),
    };
    return await postRequest(url, data, true);
  }

  ///Profile image update
  Future<HttpResult> fetchProfileImageSend(
    String path,
  ) async {
    String url = baseUrl + 'update-profil-img/';
    Dio dio = new Dio();
    final dynamic headers = await _getReqHeader();

    FormData formData = FormData.fromMap(
      {
        "avatar": await MultipartFile.fromFile(
          path,
          filename: basename(path),
        ),
      },
    );
    Response response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: headers,
      ),
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        print("$sent" +
            " Bytes of " "$total Bytes - " +
            percentage +
            " % uploaded");
      },
    );
    if (response.statusCode == 200) {
      return HttpResult(
        isSuccess: true,
        status: response.statusCode!,
        result: response.data,
      );
    }
    return HttpResult(
      isSuccess: false,
      status: -1,
      result: {},
    );
  }

  /// Send my location
  Future<HttpResult> fetchSendMyLocation(
      double lat,
      double lng,
      ) async {
    String url = baseUrl + 'send-location/';
    final data = {
      "lat": lat.toString(),
      "lng": lng.toString(),
    };
    return await postRequest(url, data, true);
  }

  /// Regions
  Future<HttpResult> fetchRegion() async {
    String url = baseUrl + 'region';
    return await getRequest(url);
  }

  /// City
  Future<HttpResult> fetchCity(
    int city,
  ) async {
    String url = baseUrl + "region?region_id=$city";
    return await getRequest(url);
  }

  /// Doctors List
  Future<HttpResult> fetchDocList(
    String text,
    int regionId,
    int cityId,
    int professionId,
  ) async {
    String _rId = regionId==-1?'':regionId.toString();
    String _cId = cityId==-1?'':cityId.toString();
    String _pId = professionId==-1?'':professionId.toString();

    String url = baseUrl +
        "doctorchoose?is_doctor=true&region_id=$_rId&city_id=$_cId&profession_id=$_pId&search=$text";
    return await getRequest(url);
  }

  /// Doctor Details
  Future<HttpResult> fetchDocDetails(int doctorId) async {
    String url = baseUrl + 'doctor-detail?doctor_id=$doctorId';
    return await getRequest(url);
  }

  /// Forgot Password
  Future<HttpResult> fetchForgotPassword(
      String email,
      ) async {
    String url = baseUrl + 'forget-password/';

    final data = {
      "username": email,
    };
    return await postRequest(url, data, false);
  }

  /// Forgot Password Accept
  Future<HttpResult> fetchForgotAccept(
      String email,
      String smsCode,
      ) async {
    String url = baseUrl + 'forgot-accept/';

    final data = {
      "username": email,
      "sms_code": smsCode,
    };
    return await postRequest(url, data, false);
  }

  /// Password Update
  Future<HttpResult> fetchPassUpdate(
      String password,
      ) async {
    String url = baseUrl + 'forget-password-update/';

    final data = {
      "new_password": password,
    };
    return await postRequest(url, data, false);
  }

  /// Categories
  Future<HttpResult> fetchCategories(String search) async {
    String url = baseUrl + 'profession?search=$search';
    return await getRequest(url);
  }

  /// Schedule Create
  Future<HttpResult> fetchScheduleSend(
    int doctorId,
    DateTime time,
    String desc,
    int profession,
  ) async {
    String url = baseUrl + 'create-schedule';
    final data = {
      'doctor': doctorId.toString(),
      'start_datetime': time.toString(),
      'desc': desc,
      'profession': profession.toString(),
    };
    return await postRequest(url, data, true);
  }

  /// Schedules Get
  Future<HttpResult> fetchScheduleGet(String status) async {
    String url = baseUrl + 'me-schedule?status=$status';
    return await getRequest(url);
  }

  /// Diagnose Result
  Future<HttpResult> fetchDiagnose(
    List<int?> ids,
  ) async {
    String url = baseUrl + 'get-result';
    final data = {
      'disease_ids': ids.join(', '),
    };
    return await postRequest(url, data, true);
  }

  /// Schedule Cancel
  Future<HttpResult> fetchScheduleCancel(
      int id,
      ) async {
    String url = baseUrl + 'set-status';
    final data = {
      'id': id.toString(),
      'status': 'canceled'
    };
    return await postRequest(url, data, true);
  }

  ///Check version
  Future<HttpResult> fetchCheckVersion(
      String version,
      String token,
      ) async {
    String url = baseUrl + 'check-version/';
    final data = {
      "version": version,
      "fctoken": token,
      "device": Platform.isIOS ? "ios" : "android",
    };
    return await postRequest(url, data, true);
  }
}
