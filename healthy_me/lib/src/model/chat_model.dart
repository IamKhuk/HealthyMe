import 'package:healthy_me/src/model/doctor_model.dart';

import 'msg_model.dart';

class ChatModel {
  DoctorModel user;
  List<MsgModel> msg;
  bool isRead;
  bool deleted;

  ChatModel({
    required this.user,
    required this.msg,
    this.isRead = false,
    this.deleted = false,
  });
}