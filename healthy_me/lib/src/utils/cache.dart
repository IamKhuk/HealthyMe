import 'package:healthy_me/src/model/api/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache{
  Future<void> saveLoginUser(LoginModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", data.token);
    prefs.setString("username", data.user.username);
    prefs.setInt("id", data.user.id);
  }
}