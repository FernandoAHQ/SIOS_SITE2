// To parse this JSON data, do
//
//     final historyResponse = historyResponseFromMap(jsonString);

import 'dart:convert';

import 'package:app/models/service.dart';


class HistoryResponse {
    HistoryResponse({
        required this.status,
        required this.services,
        required this.totalResults,
    });

    bool status;
    List<Service> services;
    int totalResults;

    factory HistoryResponse.fromJson(String str) => HistoryResponse.fromMap(json.decode(str));

    factory HistoryResponse.fromMap(Map<String, dynamic> json) => HistoryResponse(
        status: json["status"],
        services: List<Service>.from(json["services"].map((x) => Service.fromMap(x))),
        totalResults: json["totalResults"],
    );
}