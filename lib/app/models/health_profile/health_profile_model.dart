// To parse this JSON data, do
//
//     final healthProfileModel = healthProfileModelFromJson(jsonString);

import 'dart:convert';

HealthProfileModel healthProfileModelFromJson(String str) => HealthProfileModel.fromJson(json.decode(str));

String healthProfileModelToJson(HealthProfileModel data) => json.encode(data.toJson());

class HealthProfileModel {
    int? id;
    int? globalPatientId;
    dynamic heightCm;
    String? bloodGroup;
    String? gender;
    DateTime? dateOfBirth;
    DateTime? createdAt;
    DateTime? updatedAt;

    HealthProfileModel({
        this.id,
        this.globalPatientId,
        this.heightCm,
        this.bloodGroup,
        this.gender,
        this.dateOfBirth,
        this.createdAt,
        this.updatedAt,
    });

    factory HealthProfileModel.fromJson(Map<String, dynamic> json) => HealthProfileModel(
        id: json["id"],
        globalPatientId: json["globalPatientId"],
        heightCm: json["heightCm"],
        bloodGroup: json["bloodGroup"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "globalPatientId": globalPatientId,
        "heightCm": heightCm,
        "bloodGroup": bloodGroup,
        "gender": gender,
        "dateOfBirth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
