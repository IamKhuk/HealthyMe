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

  factory DiagnoseApiModel.fromJson(Map<String, dynamic> json) => DiagnoseApiModel(
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
    required this.percentage,
    required this.intro,
    required this.suggestion,
    required this.disease,
  });

  int id;
  String name;
  String text;
  double percentage;
  String intro;
  String suggestion;
  List<Disease> disease;

  factory Diagnostic.fromJson(Map<dynamic, dynamic> json) => Diagnostic(
    id: json["id"]??0,
    name: json["name"]??'',
    text: json["text"]??'',
    percentage: json["persent"]??0,
    intro: json["introdaction"]??'',
    suggestion: json["suggestion"]??'',
    disease: List<Disease>.from(json["disease"].map((x) => Disease.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "text": text,
    "persent": percentage,
    "introdaction": intro,
    "suggestion": suggestion,
    "disease": List<dynamic>.from(disease.map((x) => x.toJson())),
  };
}

class Disease {
  Disease({
    required this.drugs,
  });

  List<Drug> drugs;

  factory Disease.fromJson(Map<dynamic, dynamic> json) => Disease(
    drugs: List<Drug>.from(json["drugs"].map((x) => Drug.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "drugs": List<dynamic>.from(drugs.map((x) => x.toJson())),
  };
}

class Drug {
  Drug({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory Drug.fromJson(Map<dynamic, dynamic> json) => Drug(
    id: json["id"]??0,
    name: json["name"]??'',
    image: json["image"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
