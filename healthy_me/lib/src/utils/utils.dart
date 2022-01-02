class Utils{
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
}