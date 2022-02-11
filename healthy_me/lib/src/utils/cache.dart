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

  Future<void> saveSetMe(ProfileData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fullname", data.fullName);
    prefs.setString("username", data.username);
    prefs.setString("phone", data.phone);
    prefs.setString("avatar", data.avatar);
    prefs.setString("gender", data.gender);
    prefs.setString("email", data.email);
    prefs.setInt("id", data.id);
    prefs.setString("city", data.city);
    prefs.setString("region", data.region);
    prefs.setString("birthday", data.birthDate.toString());
  }

  Future<ProfileData> cacheGetMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ProfileData info = ProfileData(
      id: prefs.getInt("id") ?? 0,
      avatar: prefs.getString("avatar") ?? "",
      fullName: prefs.getString("name") ?? "",
      phone: prefs.getString("number") ?? "",
      gender: prefs.getString("gender") ?? "",
      birthDate: prefs.getString("birthday") == null
          ? DateTime.now()
          : DateTime.parse(
              prefs.getString("birthday") ?? "",
            ),
      city: prefs.getString('city') ?? '',
      region: prefs.getString('region') ?? '',
      email: prefs.getString('email') ?? '',
      username: prefs.getString('username') ?? '',
    );

    return info;
  }
}
