import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) =>
    ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    required this.status,
    required this.schedule,
  });

  int status;
  List<Schedule> schedule;

  factory ScheduleModel.fromJson(Map<dynamic, dynamic> json) => ScheduleModel(
        status: json["status"],
        schedule: List<Schedule>.from(
            json["schedule"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
      };
}

class Schedule {
  Schedule({
    required this.user,
    required this.doctor,
    required this.profession,
    required this.startDatetime,
    required this.desc,
  });

  int user;
  Doctor doctor;
  Profession profession;
  DateTime startDatetime;
  String desc;

  factory Schedule.fromJson(Map<dynamic, dynamic> json) => Schedule(
        user: json["user"] ?? 0,
        doctor: json['doctor'] == null
            ? Doctor.fromJson({})
            : Doctor.fromJson(json["doctor"]),
        profession: json['profession'] == null
            ? Profession.fromJson({})
            : Profession.fromJson(json["profession"]),
        startDatetime: DateTime.parse(json["start_datetime"]),
        desc: json["desc"]??'',
      );

  Map<dynamic, dynamic> toJson() => {
        "user": user,
        "doctor": doctor.toJson(),
        "profession": profession.toJson(),
        "start_datetime": startDatetime.toIso8601String(),
        "desc": desc,
      };
}

class Doctor {
  Doctor({
    required this.fullName,
    required this.avatar,
  });

  String fullName;
  String avatar;

  factory Doctor.fromJson(Map<dynamic, dynamic> json) => Doctor(
        fullName: json["fullname"]??'Unnamed',
        avatar: json["avatar"] == null ? '' : json["avatar"],
      );

  Map<dynamic, dynamic> toJson() => {
        "fullname": fullName,
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
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"]??'General',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}