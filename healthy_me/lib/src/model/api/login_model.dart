class LoginModel {
  LoginModel({
    required this.status,
    required this.msg,
    required this.user,
    required this.token,
  });

  int status;
  String msg;
  User user;
  String token;

  factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
    status: json["status"]??0,
    msg: json["msg"]??'',
    user: json["user"] == null
        ? User.fromJson({})
        : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    required this.id,
    required this.password,
    required this.username,
  });

  int id;
  String password;
  String username;

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
    id: json["id"]??0,
    password: json["password"]??'',
    username: json["username"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
    "username": username,
  };
}
