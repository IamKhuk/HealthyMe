import 'drugs_model.dart';

class DiseaseProbability {
  double percentage;
  String disease;
  String text;
  List<String> diagnose;
  String rec;
  List<DrugsModel> drugs;

  DiseaseProbability({
    required this.percentage,
    required this.disease,
    required this.text,
    required this.diagnose,
    required this.rec,
    required this.drugs,
  });
}
