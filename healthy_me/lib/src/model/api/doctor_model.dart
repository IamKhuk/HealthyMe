import 'dart:convert';

DoctorApiModel doctorApiModelFromJson(String str) =>
    DoctorApiModel.fromJson(json.decode(str));

String doctorApiModelToJson(DoctorApiModel data) => json.encode(data.toJson());

class DoctorApiModel {
  DoctorApiModel({
    required this.status,
    required this.user,
  });

  int status;
  DoctorAPI user;

  factory DoctorApiModel.fromJson(Map<String, dynamic> json) => DoctorApiModel(
        status: json["status"] ?? 0,
        user: DoctorAPI.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
      };
}

class DoctorAPI {
  DoctorAPI({
    required this.fullname,
    required this.avatar,
    required this.gender,
    required this.bio,
    required this.langtude,
    required this.latitude,
    required this.reviewAvg,
    required this.reviewCount,
    required this.profession,
    required this.region,
    required this.city,
  });

  String fullname;
  String avatar;
  String gender;
  String bio;
  double langtude;
  double latitude;
  double reviewAvg;
  int reviewCount;
  City profession;
  City region;
  City city;

  factory DoctorAPI.fromJson(Map<dynamic, dynamic> json) => DoctorAPI(
        fullname: json["fullname"] ?? 'Noname',
        avatar: json["avatar"] ?? '',
        gender: json["gender"] ?? 'man',
        bio: json["bio"] ?? '',
        langtude: json["langtude"] ?? 0,
        latitude: json["latitude"] ?? 0,
        reviewAvg:
            json["review_avg"] == null ? 5 : json["review_avg"].toDouble(),
        reviewCount: json["review_count"]??0,
        profession: json["profession"] == null
            ? City.fromJson({})
            : City.fromJson(json["profession"]),
        region: json["region"] == null
            ? City.fromJson({})
            : City.fromJson(json["region"]),
        city: json["city"] == null
            ? City.fromJson({})
            : City.fromJson(json["city"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "fullname": fullname,
        "avatar": avatar,
        "gender": gender,
        "bio": bio,
        "langtude": langtude,
        "latitude": latitude,
        "review_avg": reviewAvg,
        "review_count": reviewCount,
        "profession": profession.toJson(),
        "region": region.toJson(),
        "city": city.toJson(),
      };
}

class City {
  City({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<dynamic, dynamic> json) => City(
        id: json["id"]??0,
        name: json["name"]??'',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
