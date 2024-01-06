// To parse this JSON data, do
//
//     final apijson = apijsonFromJson(jsonString);

import 'dart:convert';

List<Apijson> apijsonFromJson(String str) => List<Apijson>.from(json.decode(str).map((x) => Apijson.fromJson(x)));

String apijsonToJson(List<Apijson> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Apijson {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Apijson({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Apijson.fromJson(Map<String, dynamic> json) => Apijson(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}
