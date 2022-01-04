import 'package:healthy_me/src/model/doctor_model.dart';

class ScheduleModel {
  DoctorModel doc;
  List<DateTime> time;
  bool completed;
  bool canceled;

  ScheduleModel({
    required this.doc,
    required this.time,
    this.completed = false,
    this.canceled = false,
  });
}
