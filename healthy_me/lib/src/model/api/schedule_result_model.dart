import 'dart:convert';

ScheduleResultModel scheduleResultModelFromJson(String str) => ScheduleResultModel.fromJson(json.decode(str));

String scheduleResultModelToJson(ScheduleResultModel data) => json.encode(data.toJson());

class ScheduleResultModel {
  ScheduleResultModel({
    required this.status,
    required this.schedule,
  });

  int status;
  ScheduleResult schedule;

  factory ScheduleResultModel.fromJson(Map<String, dynamic> json) => ScheduleResultModel(
    status: json["status"],
    schedule: ScheduleResult.fromJson(json["schedule"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "schedule": schedule.toJson(),
  };
}

class ScheduleResult {
  ScheduleResult({
    required this.id,
    required this.user,
    required this.doctor,
    required this.profession,
    required this.status,
    required this.startDatetime,
    required this.desc,
  });

  int id;
  int user;
  Doctor doctor;
  Profession profession;
  String status;
  DateTime startDatetime;
  String desc;

  factory ScheduleResult.fromJson(Map<String, dynamic> json) => ScheduleResult(
    id: json["id"],
    user: json["user"],
    doctor: Doctor.fromJson(json["doctor"]),
    profession: Profession.fromJson(json["profession"]),
    status: json["status"],
    startDatetime: DateTime.parse(json["start_datetime"]),
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "doctor": doctor.toJson(),
    "profession": profession.toJson(),
    "status": status,
    "start_datetime": startDatetime.toIso8601String(),
    "desc": desc,
  };
}

class Doctor {
  Doctor({
    required this.id,
    required this.fullname,
    required this.avatar,
  });

  int id;
  String fullname;
  String avatar;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    fullname: json["fullname"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "avatar": avatar,
  };
}

class Profession {
  Profession({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
