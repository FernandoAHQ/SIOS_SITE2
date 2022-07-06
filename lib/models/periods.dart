// To parse this JSON data, do
//
//     final logResponse = logResponseFromMap(jsonString);

import 'dart:convert';

class Period {
    Period({
        required this.name,
        required this.ranking,
    });

    List<Ranked> ranking;
    String name;

    factory Period.fromJson(String str) => Period.fromMap(json.decode(str));

    factory Period.fromMap(Map<String, dynamic> json) => Period(
        name: json['periodo']['name'],
        ranking: List<Ranked>.from(json['periodo']['ranking'].map((x) => Ranked.fromMap(x))),
    );
}

class Ranked {
    Ranked({
        required this.name,
        required this.image,
        required this.points,
    });

    String name;
    String image;
    int points;

    factory Ranked.fromJson(String str) => Ranked.fromMap(json.decode(str));

    factory Ranked.fromMap(Map<String, dynamic> json) => Ranked(
        name: json["user"]["name"],
        image: json["user"]["image"],
        points: json["points"],
    );
}
