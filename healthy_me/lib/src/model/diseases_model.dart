import 'drugs_model.dart';

class Diseases {
  String name;
  List<int> conditions;
  String intro;
  List<String> diagnose;
  String recommendation;
  List<DrugsModel> drugs;
  int sum;

  Diseases({
    required this.name,
    required this.conditions,
    required this.intro,
    required this.diagnose,
    this.recommendation = '',
    required this.drugs,
    this.sum = 0,
  });
}
