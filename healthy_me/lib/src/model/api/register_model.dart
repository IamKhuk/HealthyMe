class RegisterModel {
  RegisterModel({
    required this.status,
    required this.msg,
    required this.user,
  });

  int status;
  String msg;
  User user;

  factory RegisterModel.fromJson(Map<dynamic, dynamic> json) => RegisterModel(
    status: json["status"]??0,
    msg: json["msg"]??'',
    user: json["user"] == null
        ? User.fromJson({})
        : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.phone,
  });

  int id;
  String username;
  String phone;

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
    id: json["id"]??0,
    username: json["username"]??'',
    phone: json["phone"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "phone": phone,
  };
}
