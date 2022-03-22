import 'dart:convert';

DiagnoseApiModel diagnoseApiModelFromJson(String str) => DiagnoseApiModel.fromJson(json.decode(str));

String diagnoseApiModelToJson(DiagnoseApiModel data) => json.encode(data.toJson());

class DiagnoseApiModel {
  DiagnoseApiModel({
    required this.status,
    required this.diagnostics,
  });

  int status;
  List<Diagnostic> diagnostics;

  factory DiagnoseApiModel.fromJson(Map<dynamic, dynamic> json) => DiagnoseApiModel(
    status: json["status"],
    diagnostics: List<Diagnostic>.from(json["diagnostics"].map((x) => Diagnostic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "diagnostics": List<dynamic>.from(diagnostics.map((x) => x.toJson())),
  };
}

class Diagnostic {
  Diagnostic({
    required this.id,
    required this.name,
    required this.text,
    required this.percent,
    required this.introduction,
    required this.suggestion,
  });

  int id;
  String name;
  String text;
  double percent;
  String introduction;
  String suggestion;

  factory Diagnostic.fromJson(Map<dynamic, dynamic> json) => Diagnostic(
    id: json["id"]??0,
    name: json["name"]??'',
    text: json["text"]??'',
    percent: json["persent"].toDouble()??0,
    introduction: json["introdaction"]??'',
    suggestion: json["suggestion"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "text": text,
    "persent": percent,
    "introdaction": introduction,
    "suggestion": suggestion,
  };
}
