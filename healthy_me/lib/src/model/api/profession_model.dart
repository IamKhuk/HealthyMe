class ProfessionModel {
  ProfessionModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory ProfessionModel.fromJson(Map<dynamic, dynamic> json) => ProfessionModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Result.fromJson(Map<dynamic, dynamic> json) => Result(
    id: json["id"]??0,
    name: json["name"]??'Unnamed',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
