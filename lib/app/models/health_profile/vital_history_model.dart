// To parse this JSON data, do
//
//     final vitalHistoryModel = vitalHistoryModelFromJson(jsonString);

import 'dart:convert';

List<VitalHistoryModel> vitalHistoryModelFromJson(String str) => List<VitalHistoryModel>.from(json.decode(str).map((x) => VitalHistoryModel.fromJson(x)));

String vitalHistoryModelToJson(List<VitalHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VitalHistoryModel {
  dynamic id;
  dynamic globalPatientId;
   dynamic weightKg;
  dynamic bloodGlucoseMgdl;
  dynamic bloodPressureSystolic;
  dynamic bloodPressureDiastolic;
    String? bloodPressureDisplay;
    DateTime? recordedAt;
    String? notes;
    DateTime? createdAt;
    DateTime? updatedAt;

    VitalHistoryModel({
        this.id,
        this.globalPatientId,
        this.weightKg,
        this.bloodGlucoseMgdl,
        this.bloodPressureSystolic,
        this.bloodPressureDiastolic,
        this.bloodPressureDisplay,
        this.recordedAt,
        this.notes,
        this.createdAt,
        this.updatedAt,
    });

    factory VitalHistoryModel.fromJson(Map<String, dynamic> json) => VitalHistoryModel(
        id: json["id"],
        globalPatientId: json["globalPatientId"],
        weightKg: json["weightKg"]?.toDouble(),
        bloodGlucoseMgdl: json["bloodGlucoseMgdl"],
        bloodPressureSystolic: json["bloodPressureSystolic"],
        bloodPressureDiastolic: json["bloodPressureDiastolic"],
        bloodPressureDisplay: json["bloodPressureDisplay"],
        recordedAt: json["recordedAt"] == null ? null : DateTime.parse(json["recordedAt"]),
        notes: json["notes"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "globalPatientId": globalPatientId,
        "weightKg": weightKg,
        "bloodGlucoseMgdl": bloodGlucoseMgdl,
        "bloodPressureSystolic": bloodPressureSystolic,
        "bloodPressureDiastolic": bloodPressureDiastolic,
        "bloodPressureDisplay": bloodPressureDisplay,
        "recordedAt": recordedAt?.toIso8601String(),
        "notes": notes,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
