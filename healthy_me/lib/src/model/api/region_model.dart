class RegionModel {
  RegionModel({
    required this.status,
    required this.data,
  });

  int status;
  List<RegionsResult> data;

  factory RegionModel.fromJson(Map<dynamic, dynamic> json) => RegionModel(
    status: json["status"] == null ? 0 :json["status"],
    data: List<RegionsResult>.from(json["data"].map((x) => RegionsResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RegionsResult {
  RegionsResult({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory RegionsResult.fromJson(Map<dynamic, dynamic> json) => RegionsResult(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
