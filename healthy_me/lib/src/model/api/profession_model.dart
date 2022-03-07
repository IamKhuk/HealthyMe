class ProfessionModel {
  ProfessionModel({
    required this.count,
    required this.results,
  });

  int count;
  List<ProfessionResult> results;

  factory ProfessionModel.fromJson(Map<dynamic, dynamic> json) => ProfessionModel(
    count: json["count"],
    results: List<ProfessionResult>.from(json["results"].map((x) => ProfessionResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ProfessionResult {
  ProfessionResult({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory ProfessionResult.fromJson(Map<dynamic, dynamic> json) => ProfessionResult(
    id: json["id"]??0,
    name: json["name"]??'Unnamed',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
