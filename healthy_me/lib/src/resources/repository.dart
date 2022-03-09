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
    String phone,
  ) =>
      apiProvider.fetchRegister(
        username,
        password,
        phone,
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
      ) =>
      apiProvider.fetchScheduleSend(
        doctorId,
        time,
        desc,
      );

  Future<HttpResult> fetchCategories(String search) =>
      apiProvider.fetchCategories(search);

  Future<HttpResult> fetchDocDetails(int doctorId) =>
      apiProvider.fetchDocDetails(doctorId);

  Future<HttpResult> fetchMe() => apiProvider.fetchMe();

  Future<void> cacheSetMe(ProfileData data) => appCache.saveSetMe(data);

  Future<ProfileData> cacheGetMe() => appCache.cacheGetMe();

  Future<void> cacheLoginUser(LoginModel data) => appCache.saveLoginUser(data);
}
