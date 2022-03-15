class ConditionsModel {
  int id;
  String name;
  bool chosen;
  String text;
  String intro;

  ConditionsModel({
    required this.id,
    required this.name,
    this.chosen = false,
    required this.text,
    required this.intro,
  });
}
