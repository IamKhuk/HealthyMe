import 'package:healthy_me/src/model/visit_date_model.dart';

class Utils {
  static double starFormat(double k) {
    if (k == 0) {
      return 0;
    } else if (k > 0 && k <= 0.5) {
      return 0.5;
    } else if (k > 0.5 && k <= 1.2) {
      return 1;
    } else if (k > 1.2 && k <= 1.7) {
      return 1.5;
    } else if (k > 1.7 && k <= 2.2) {
      return 2;
    } else if (k > 2.2 && k <= 2.7) {
      return 2.5;
    } else if (k > 2.7 && k <= 3.2) {
      return 3;
    } else if (k > 3.2 && k <= 3.7) {
      return 3.5;
    } else if (k > 3.7 && k <= 4.2) {
      return 4;
    } else if (k > 4.2 && k <= 4.7) {
      return 4.5;
    } else if (k > 4.7 && k <= 5) {
      return 5;
    } else {
      return k;
    }
  }

  static String dateFormat(DateTime time1, DateTime time2) {
    String weekDay = '';
    String month = '';
    String t1 = '';
    String t2 = '';
    String h1 = '';
    String h2 = '';
    time1.weekday == 1
        ? weekDay = 'Monday'
        : time1.weekday == 2
            ? weekDay = 'Tuesday'
            : time1.weekday == 3
                ? weekDay = 'Wednesday'
                : time1.weekday == 4
                    ? weekDay = 'Thursday'
                    : time1.weekday == 5
                        ? weekDay = 'Friday'
                        : time1.weekday == 6
                            ? weekDay = 'Saturday'
                            : weekDay = 'Sunday';

    time1.month == 1
        ? month = 'January'
        : time1.month == 2
            ? month = 'February'
            : time1.month == 3
                ? month = 'March'
                : time1.month == 4
                    ? month = 'April'
                    : time1.month == 5
                        ? month = 'May'
                        : time1.month == 6
                            ? month = 'June'
                            : time1.month == 7
                                ? month = 'July'
                                : time1.month == 8
                                    ? month = 'August'
                                    : time1.month == 9
                                        ? month = 'September'
                                        : time1.month == 10
                                            ? month = 'October'
                                            : time1.month == 11
                                                ? month = 'November'
                                                : month = 'December';

    time1.hour < 13 ? t1 = 'AM' : t1 = 'PM';
    time2.hour < 13 ? t2 = 'AM' : t2 = 'PM';
    h1 = time1.hour < 13 ? time1.hour.toString() : (time1.hour - 12).toString();
    h2 = time2.hour < 13 ? time2.hour.toString() : (time2.hour - 12).toString();

    return weekDay +
        ', ' +
        month +
        ' ' +
        time1.day.toString() +
        ', ' +
        time1.year.toString() +
        ', ' +
        h1 +
        ' ' +
        t1 +
        ' - ' +
        h2 +
        ' ' +
        t2;
  }

  static String scheduleDateFormat(DateTime time1, DateTime time2) {
    String weekDay = '';
    String month = '';
    time1.weekday == 1
        ? weekDay = 'Monday'
        : time1.weekday == 2
            ? weekDay = 'Tuesday'
            : time1.weekday == 3
                ? weekDay = 'Wednesday'
                : time1.weekday == 4
                    ? weekDay = 'Thursday'
                    : time1.weekday == 5
                        ? weekDay = 'Friday'
                        : time1.weekday == 6
                            ? weekDay = 'Saturday'
                            : weekDay = 'Sunday';

    time1.month == 1
        ? month = 'Jan'
        : time1.month == 2
            ? month = 'Feb'
            : time1.month == 3
                ? month = 'March'
                : time1.month == 4
                    ? month = 'Apr'
                    : time1.month == 5
                        ? month = 'May'
                        : time1.month == 6
                            ? month = 'June'
                            : time1.month == 7
                                ? month = 'July'
                                : time1.month == 8
                                    ? month = 'Aug'
                                    : time1.month == 9
                                        ? month = 'Sep'
                                        : time1.month == 10
                                            ? month = 'Oct'
                                            : time1.month == 11
                                                ? month = 'Nov'
                                                : month = 'Dec';

    return weekDay +
        ', ' +
        month +
        ' ' +
        time1.day.toString() +
        ', ' +
        time1.year.toString();
  }

  static String scheduleHourFormat(DateTime time1, DateTime time2) {
    String t1 = '';
    String t2 = '';
    String h1 = '';
    String h2 = '';

    time1.hour < 13 ? t1 = 'AM' : t1 = 'PM';
    time2.hour < 13 ? t2 = 'AM' : t2 = 'PM';
    h1 = time1.hour < 13 ? time1.hour.toString() : (time1.hour - 12).toString();
    h2 = time2.hour < 13 ? time2.hour.toString() : (time2.hour - 12).toString();

    return h1 + ' ' + t1 + ' - ' + h2 + ' ' + t2;
  }

  static String monthFormat(int time) {
    String month = '';
    time == 1
        ? month = 'Jan'
        : time == 2
            ? month = 'Feb'
            : time == 3
                ? month = 'March'
                : time == 4
                    ? month = 'Apr'
                    : time == 5
                        ? month = 'May'
                        : time == 6
                            ? month = 'June'
                            : time == 7
                                ? month = 'July'
                                : time == 8
                                    ? month = 'Aug'
                                    : time == 9
                                        ? month = 'Sep'
                                        : time == 10
                                            ? month = 'Oct'
                                            : time == 11
                                                ? month = 'Nov'
                                                : month = 'Dec';

    return month;
  }

  static String weekFormat(int time) {
    String weekDay = '';
    time == 1
        ? weekDay = 'Monday'
        : time == 2
            ? weekDay = 'Tuesday'
            : time == 3
                ? weekDay = 'Wednesday'
                : time == 4
                    ? weekDay = 'Thursday'
                    : time == 5
                        ? weekDay = 'Friday'
                        : time == 6
                            ? weekDay = 'Saturday'
                            : weekDay = 'Sunday';

    return weekDay;
  }

  static List<VisitDateModel> visitDateFormat(DateTime time) {
    List<VisitDateModel> list = [];
    list.add(VisitDateModel(
      day: time.day,
      week: time.weekday,
      month: time.month,
      year: time.year,
    ));
    for (int i = 1; i < 90; i++) {
      list.add(
        VisitDateModel(
          day: time.add(Duration(days: i)).day,
          week: time.add(Duration(days: i)).weekday,
          month: time.add(Duration(days: i)).month,
          year: time.add(Duration(days: i)).year,
        ),
      );
    }
    return list;
  }

  static List<TimeModel> visitTimeFormat() {
    List<TimeModel> l = [];
    for (int i = 8; i <= 17; i++) {
      for (int j = 0; j <= 50; j += 10) {
        l.add(TimeModel(hour: i, minutes: j));
      }
    }
    return l;
  }

  static String minuteFormat(int minute) {
    String i = '';
    minute == 0 ? i = '00' : i = minute.toString();
    return i;
  }

  static bool passwordValidator(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool emailValidator(String value){
    String  pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String phoneFormat(String k) {
    if (k.contains('+')) {
      List l = k.split('+').toList();
      String s = '';
      for (int i = 0; i < l[1].length; i++) {
        s += l[1][i];
      }
      return s;
    } else if (k.length == 12) {
      return k;
    } else if (k.length == 9) {
      String s = "998";
      for (int i = 0; i < k.length; i++) {
        s += k[i];
      }
      return s;
    } else {
      return k;
    }
  }

  static String phoneTextFormat(String k) {
    if (k.contains('+')) {
      String s = "";
      for (int i = 0; i < k.length; i++) {
        s += k[i];
        if (i == 3 || i == 5 || i == 8 || i == 10) {
          s += " ";
        }
      }
      return s;
    } else if (k.length == 12) {
      String s = "+";
      for (int i = 0; i < k.length; i++) {
        s += k[i];
        if (i == 2 || i == 4 || i == 7 || i == 9) {
          s += " ";
        }
      }
      return s;
    } else if (k.length == 9) {
      String s = "";
      for (int i = 0; i < k.length; i++) {
        s += k[i];
        if (i == 1 || i == 4 || i == 6) {
          s += " ";
        }
      }
      return '+998 ' + s;
    } else {
      return k;
    }
  }
}

class TimeModel {
  int hour;
  int minutes;
  bool free;

  TimeModel({
    required this.hour,
    required this.minutes,
    this.free = true,
  });
}
