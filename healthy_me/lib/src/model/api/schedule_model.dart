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
    required this.id,
    required this.user,
    required this.doctor,
    required this.profession,
    required this.startDatetime,
    required this.desc,
  });

  int id;
  int user;
  ScheduleDoctor doctor;
  Profession profession;
  DateTime startDatetime;
  String desc;

  factory Schedule.fromJson(Map<dynamic, dynamic> json) => Schedule(
        id: json['id'] ?? 0,
        user: json["user"] ?? 0,
        doctor: json['doctor'] == null
            ? ScheduleDoctor.fromJson({})
            : ScheduleDoctor.fromJson(json["doctor"]),
        profession: json['profession'] == null
            ? Profession.fromJson({})
            : Profession.fromJson(json["profession"]),
        startDatetime: DateTime.parse(json["start_datetime"]),
        desc: json["desc"] ?? '',
      );

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        "user": user,
        "doctor": doctor.toJson(),
        "profession": profession.toJson(),
        "start_datetime": startDatetime.toIso8601String(),
        "desc": desc,
      };
}

class ScheduleDoctor {
  ScheduleDoctor({
    required this.id,
    required this.fullName,
    required this.avatar,
  });

  int id;
  String fullName;
  String avatar;

  factory ScheduleDoctor.fromJson(Map<dynamic, dynamic> json) => ScheduleDoctor(
        id: json['id'] ?? 0,
        fullName: json["fullname"] ?? 'Unnamed',
        avatar: json["avatar"] == null ? '' : json["avatar"],
      );

  Map<dynamic, dynamic> toJson() => {
        'id': id,
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
        name: json["name"] ?? 'General',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
