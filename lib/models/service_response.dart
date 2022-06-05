import 'dart:convert';

import 'package:app/models/models.dart';

class ServiceResponse {
    ServiceResponse({
        required this.status,
        required this.service,
    });

    bool status;
    Service service;

    factory ServiceResponse.fromJson(String str) => ServiceResponse.fromMap(json.decode(str));

    factory ServiceResponse.fromMap(Map<String, dynamic> json) => ServiceResponse(
        status: json["status"],
        service: Service.fromMap(json["service"]),
    );

}