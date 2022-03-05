import 'package:healthy_me/src/model/api/profile_model.dart';

class DoctorsListModel {
  DoctorsListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<DocListResult> results;

  factory DoctorsListModel.fromJson(Map<dynamic, dynamic> json) => DoctorsListModel(
    count: json["count"]??0,
    next: json["next"]??0,
    previous: json["previous"]??0,
    results: List<DocListResult>.from(json["results"].map((x) => DocListResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class DocListResult {
  DocListResult({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.reviewAvg,
    required this.reviewCount,
    required this.profession,
    required this.region,
    required this.city,
  });

  int id;
  String fullName;
  String avatar;
  double reviewAvg;
  int reviewCount;
  Profession profession;
  City region;
  City city;

  factory DocListResult.fromJson(Map<dynamic, dynamic> json) => DocListResult(
    id: json["id"]??0,
    fullName: json["fullname"]??'Unnamed',
    avatar: json["avatar"]??'',
    reviewAvg: json["review_avg"].toDouble()??5,
    reviewCount: json["review_count"]??0,
    profession: Profession.fromJson(json["profession"]),
    region: json["region"] == null
        ? City.fromJson({})
        : City.fromJson(json["region"]),
    city: json["city"] == null
        ? City.fromJson({})
        : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullName,
    "avatar": avatar,
    "review_avg": reviewAvg,
    "review_count": reviewCount,
    "profession": profession.toJson(),
    "region": region,
    "city": city,
  };
}

class Profession {
  Profession({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Profession.fromJson(Map<dynamic, dynamic> json) => Profession(
    id: json["id"]??0,
    name: json["name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
