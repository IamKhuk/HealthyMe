class ConditionsModel {
  int id;
  String name;
  bool chosen;

  ConditionsModel({
    required this.id,
    required this.name,
    this.chosen = false,
  });
}
