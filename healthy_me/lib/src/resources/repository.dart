import 'package:healthy_me/src/model/api/login_model.dart';
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

  Future<void> cacheLoginUser(LoginModel data) => appCache.saveLoginUser(data);
}
