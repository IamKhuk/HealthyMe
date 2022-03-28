import 'package:healthy_me/src/model/api/login_model.dart';
import 'package:healthy_me/src/model/api/profile_model.dart';
import 'package:healthy_me/src/model/event_bus/http_result.dart';
import 'package:healthy_me/src/utils/cache.dart';

import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();
  final appCache = Cache();

  Future<HttpResult> fetchRegister(
    String username,
    String password,
    String email,
  ) =>
      apiProvider.fetchRegister(
        username,
        password,
        email,
      );

  Future<HttpResult> fetchAcceptUser(
    String username,
    String smsCode,
  ) =>
      apiProvider.fetchAcceptUser(
        username,
        smsCode,
      );

  Future<HttpResult> fetchLogin(
    String username,
    String password,
  ) =>
      apiProvider.fetchLogin(
        username,
        password,
      );

  Future<HttpResult> fetchUpdateProfile(
    ProfileData info,
  ) =>
      apiProvider.fetchUpdateProfile(info);

  Future<HttpResult> fetchProfileImageSend(
    String path,
  ) =>
      apiProvider.fetchProfileImageSend(
        path,
      );

  Future<HttpResult> fetchRegion() => apiProvider.fetchRegion();

  Future<HttpResult> fetchCity(
    int city,
  ) =>
      apiProvider.fetchCity(
        city,
      );

  Future<HttpResult> fetchDocList(
    String text,
    int regionId,
    int cityId,
    int professionId,
  ) =>
      apiProvider.fetchDocList(
        text,
        regionId,
        cityId,
        professionId,
      );

  Future<HttpResult> fetchScheduleSend(
    int doctorId,
    DateTime time,
    String desc,
    int professionId,
  ) =>
      apiProvider.fetchScheduleSend(
        doctorId,
        time,
        desc,
        professionId,
      );

  Future<HttpResult> fetchSendMyLocation(
      double lat,
      double lng,
      ) =>
      apiProvider.fetchSendMyLocation(
        lat,
        lng,
      );

  Future<HttpResult> fetchCheckVersion(
      String version,
      String token,
      ) =>
      apiProvider.fetchCheckVersion(
        version,
        token,
      );

  Future<HttpResult> fetchForgotPassword(
      String email,
      ) =>
      apiProvider.fetchForgotPassword(
        email,
      );

  Future<HttpResult> fetchForgotAccept(
      String email,
      String code,
      ) =>
      apiProvider.fetchForgotAccept(
        email,
        code,
      );

  Future<HttpResult> fetchPassUpdate(
      String newPass,
      ) =>
      apiProvider.fetchPassUpdate(
        newPass,
      );

  Future<HttpResult> fetchUpdatePass(
      String oldPass,
      String newPass,
      ) =>
      apiProvider.fetchUpdatePass(
        oldPass,
        newPass,
      );

  Future<HttpResult> fetchDiagnose(List<int?> ids) =>
      apiProvider.fetchDiagnose(ids);

  Future<HttpResult> fetchScheduleGet(String status) =>
      apiProvider.fetchScheduleGet(status);

  Future<HttpResult> fetchCategories(String search) =>
      apiProvider.fetchCategories(search);

  Future<HttpResult> fetchDocDetails(int doctorId) =>
      apiProvider.fetchDocDetails(doctorId);

  Future<HttpResult> fetchScheduleCancel(int id) =>
      apiProvider.fetchScheduleCancel(id);

  Future<HttpResult> fetchMe() => apiProvider.fetchMe();

  Future<void> cacheSetMe(ProfileData data) => appCache.saveSetMe(data);

  Future<ProfileData> cacheGetMe() => appCache.cacheGetMe();

  Future<void> cacheLoginUser(LoginModel data) => appCache.saveLoginUser(data);

  Future<void> cacheToken(String token) => appCache.saveToken(token);
}
