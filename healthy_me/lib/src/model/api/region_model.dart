class RegionModel {
  RegionModel({
    required this.status,
    required this.data,
  });

  int status;
  List<RegionData> data;

  factory RegionModel.fromJson(Map<dynamic, dynamic> json) => RegionModel(
    status: json["status"],
    data: List<RegionData>.from(json["data"].map((x) => RegionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RegionData {
  RegionData({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory RegionData.fromJson(Map<dynamic, dynamic> json) => RegionData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
