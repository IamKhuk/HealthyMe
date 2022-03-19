import 'package:healthy_me/src/model/doctor_model.dart';

class ScheduleNotModel {
  DoctorModel doc;
  List<DateTime> time;
  bool completed;
  bool canceled;

  ScheduleNotModel({
    required this.doc,
    required this.time,
    this.completed = false,
    this.canceled = false,
  });
}
