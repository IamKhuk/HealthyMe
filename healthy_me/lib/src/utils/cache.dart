import 'package:healthy_me/src/model/api/login_model.dart';
import 'package:healthy_me/src/model/api/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  Future<void> saveLoginUser(LoginModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", data.token);
    prefs.setString("username", data.user.username);
    prefs.setInt("id", data.user.id);
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  Future<void> saveSetMe(ProfileData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fullname", data.fullName);
    prefs.setString("username", data.username);
    prefs.setString("phone", data.phone);
    prefs.setString("avatar", data.avatar);
    prefs.setString("gender", data.gender);
    prefs.setString("email", data.email);
    prefs.setInt("id", data.id);
    prefs.setString("city", data.city.name);
    prefs.setString("region", data.region.name);
    prefs.setInt('regionId', data.region.id);
    prefs.setInt('cityId', data.city.id);
    prefs.setString("birth_date", data.birthDate.toString());
  }

  Future<ProfileData> cacheGetMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ProfileData info = ProfileData(
      id: prefs.getInt("id") ?? 0,
      avatar: prefs.getString("avatar") ?? "",
      fullName: prefs.getString("fullname") ?? "",
      phone: prefs.getString("phone") ?? "",
      gender: prefs.getString("gender") ?? "",
      birthDate: prefs.getString("birth_date") == null
          ? DateTime.now()
          : DateTime.parse(
              prefs.getString("birth_date") ?? "",
            ),
      region: City(
        id: prefs.getInt("regionId") ?? -1,
        name: prefs.getString("region") ?? "",
      ),
      city: City(
        id: prefs.getInt("cityId") ?? -1,
        name: prefs.getString("city") ?? "",
      ),
      email: prefs.getString('email') ?? '',
      username: prefs.getString('username') ?? '',
    );

    return info;
  }
}
