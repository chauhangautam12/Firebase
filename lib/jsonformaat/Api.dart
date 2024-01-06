// To parse this JSON data, do
//
//     final apifeach = apifeachFromJson(jsonString);

import 'dart:convert';

List<Apifeach> apifeachFromJson(String str) => List<Apifeach>.from(json.decode(str).map((x) => Apifeach.fromJson(x)));

String apifeachToJson(List<Apifeach> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Apifeach {
  int userId;
  int id;
  String title;
  String body;

  Apifeach({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Apifeach.fromJson(Map<String, dynamic> json) => Apifeach(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
