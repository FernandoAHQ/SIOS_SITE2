// To parse this JSON data, do
//
//     final logResponse = logResponseFromMap(jsonString);

import 'dart:convert';

class LogResponse {
    LogResponse({
        required this.status,
        required this.bitacora,
        required this.totalResults,
    });

    bool status;
    List<Bitacora> bitacora;
    int? totalResults;

    factory LogResponse.fromJson(String str) => LogResponse.fromMap(json.decode(str));

    factory LogResponse.fromMap(Map<String, dynamic> json) => LogResponse(
        status: json["status"],
        bitacora: List<Bitacora>.from(json["bitacora"].map((x) => Bitacora.fromMap(x))),
        totalResults: json["totalResults"],
    );
}

class Bitacora {
    Bitacora({
        required this.id,
        required this.description,
        required this.solution,
    });

    String id;
    String description;
    String solution;

    factory Bitacora.fromJson(String str) => Bitacora.fromMap(json.decode(str));

    factory Bitacora.fromMap(Map<String, dynamic> json) => Bitacora(
        id: json["_id"],
        description: json["description"],
        solution: json["solution"],
    );
}
