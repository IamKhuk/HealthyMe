class ForgotAcceptModel {
  ForgotAcceptModel({
    required this.status,
    required this.user,
    required this.token,
  });

  int status;
  UserAccept user;
  String token;

  factory ForgotAcceptModel.fromJson(Map<dynamic, dynamic> json) => ForgotAcceptModel(
    status: json["status"]??0,
    user: json["user"] == null
        ? UserAccept.fromJson({})
        : UserAccept.fromJson(json["user"]),
    token: json["token"]??'',
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user.toJson(),
    "token": token,
  };
}

class UserAccept {
  UserAccept({
    required this.id,
    required this.username,
    required this.code,
  });

  int id;
  String username;
  int code;

  factory UserAccept.fromJson(Map<dynamic, dynamic> json) => UserAccept(
    id: json["id"]??0,
    username: json["username"]??'',
    code: json["smscode"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "smscode": code,
    "username": username,
  };
}
