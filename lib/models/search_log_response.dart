// To parse this JSON data, do
//
//     final searchLogResponse = searchLogResponseFromMap(jsonString);

import 'dart:convert';

import 'package:app/models/log_response.dart';

class SearchLogResponse {
    SearchLogResponse({
        required this.status,
        required this.bitacora,
    });

    bool status;
    List<Bitacora> bitacora;

    factory SearchLogResponse.fromJson(String str) => SearchLogResponse.fromMap(json.decode(str));

    factory SearchLogResponse.fromMap(Map<String, dynamic> json) => SearchLogResponse(
        status: json["status"],
        bitacora: List<Bitacora>.from(json["bitacora"].map((x) => Bitacora.fromMap(x))),
    );
}