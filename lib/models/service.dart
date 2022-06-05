// To parse this JSON data, do
//
//     final serviceResponse = serviceResponseFromMap(jsonString);

import 'dart:convert';

class Service {
    Service({
        required this.id,
        required this.report,
        this.user,
        required this.status,
        required this.device,
        required this.staff,
        required this.createdAt,
        required this.updatedAt,
        required this.assignedTo,
        required this.severity,
    });

    String id;
    Report report;
    AssignedTo? user;
    String status;
    List<dynamic> device;
    List<dynamic> staff;
    DateTime createdAt;
    DateTime updatedAt;
    AssignedTo assignedTo;
    String severity;

    String? feedback;
    String? description;
    String? solution;
    List<String>? devices;


    factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

    factory Service.fromMap(Map<String, dynamic> json) => Service(
        id: json["_id"],
        report: Report.fromMap(json["report"]),
        user: AssignedTo.fromMap(json["user"]),
        status: json["status"],
        device: List<dynamic>.from(json["device"].map((x) => x)),
        staff: List<dynamic>.from(json["staff"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        assignedTo: AssignedTo.fromMap(json["assignedTo"]),
        severity: json["severity"],
    );

}

class AssignedTo {
    AssignedTo({
        required this.id,
        required this.name,
        required this.username,
        required this.password,
        required this.image,
        required this.role,
        required this.online,
        required this.isActive,
        required this.v,
    });

    String id;
    String name;
    String username;
    String password;
    String image;
    String role;
    bool online;
    bool isActive;
    int v;

    factory AssignedTo.fromJson(String str) => AssignedTo.fromMap(json.decode(str));

    factory AssignedTo.fromMap(Map<String, dynamic> json) => AssignedTo(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        image: json["image"],
        role: json["role"],
        online: json["online"],
        isActive: json["isActive"],
        v: json["__v"],
    );

}

class Report {
    Report({
        required this.id,
        required this.department,
        required this.title,
        required this.description,
        required this.category,
        required this.isAssigned,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    Department department;
    String title;
    String description;
    String category;
    bool isAssigned;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Report.fromJson(String str) => Report.fromMap(json.decode(str));

    factory Report.fromMap(Map<String, dynamic> json) => Report(
        id: json["_id"],
        department: Department.fromMap(json["department"]),
        title: json["title"],
        description: json["description"],
        category: json["category"],
        isAssigned: json["isAssigned"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

}

class Department {
    Department({
        required this.id,
        required this.name,
        required this.ubication,
        required this.user,
        required this.v,
    });

    String id;
    String name;
    String ubication;
    String user;
    int v;

    factory Department.fromJson(String str) => Department.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Department.fromMap(Map<String, dynamic> json) => Department(
        id: json["_id"],
        name: json["name"],
        ubication: json["ubication"],
        user: json["user"],
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "ubication": ubication,
        "user": user,
        "__v": v,
    };
}
