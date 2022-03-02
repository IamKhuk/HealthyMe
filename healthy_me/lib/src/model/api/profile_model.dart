class ProfileModel {
  ProfileModel({
    required this.status,
    required this.user,
  });

  int status;
  ProfileData user;

  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) => ProfileModel(
    status: json["status"]??0,
    user: ProfileData.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user.toJson(),
  };
}

class ProfileData {
  ProfileData({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.username,
    required this.email,
    required this.gender,
    required this.phone,
    required this.birthDate,
    required this.region,
    required this.city,
  });

  int id;
  String fullName;
  String avatar;
  String username;
  String email;
  String gender;
  String phone;
  DateTime birthDate;
  City region;
  City city;

  factory ProfileData.fromJson(Map<dynamic, dynamic> json) {
    DateTime dateTime;
    try {
      dateTime = json["birth_date"] == null
          ? DateTime.now()
          : DateTime.parse(
        json["birth_date"],
      );
    } catch (_) {
      String s = json["birth_date"] ?? "1900-02-16";
      dateTime = DateTime(
        int.parse(s.split('-')[0]),
        int.parse(s.split('-')[1]),
        int.parse(s.split('-')[2]),
      );
    }

    return ProfileData(
      id: json["id"]??0,
      fullName: json["fullname"]??'',
      avatar: json["avatar"]??'',
      username: json["username"]??'',
      email: json["email"]??'',
      gender: json["gender"]??'man',
      phone: json["phone"]??'',
      birthDate: dateTime,
      region: json["region"] == null
          ? City.fromJson({})
          : City.fromJson(json["region"]),
      city: json["city"] == null
          ? City.fromJson({})
          : City.fromJson(json["city"]),
    );
  }

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "fullname": fullName,
    "avatar": avatar,
    "username": username,
    "email": email,
    "gender": gender,
    "phone": phone,
    "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "region": region,
    "city": city,
  };
}

class City {
  City({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] ?? -1,
    name: json["name"] ?? "",
  );
}
