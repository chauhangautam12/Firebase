// To parse this JSON data, do
//
//     final datafeach = datafeachFromJson(jsonString);

import 'dart:convert';

Datafeach datafeachFromJson(String str) => Datafeach.fromJson(json.decode(str));

String datafeachToJson(Datafeach data) => json.encode(data.toJson());

class Datafeach {
  String name;
  String photo;

  Datafeach({
    required this.name,
    required this.photo,
  });

  factory Datafeach.fromJson(Map<String, dynamic> json) => Datafeach(
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "photo": photo,
  };
}
