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
}
