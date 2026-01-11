// To parse this JSON data, do
//
//     final labReportModel = labReportModelFromJson(jsonString);

import 'dart:convert';

List<LabReportModel> labReportModelFromJson(String str) => List<LabReportModel>.from(json.decode(str).map((x) => LabReportModel.fromJson(x)));

String labReportModelToJson(List<LabReportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LabReportModel {
    int? id;
    int? patientId;
    String? reportType;
    String? fileUrl;
    String? fileFormat;
    DateTime? reportDate;
    String? doctorName;
    String? labName;
    String? aiSummary;
    String? fileName;
    int? fileSize;
    String? notes;
    DateTime? createdAt;
    DateTime? updatedAt;

    LabReportModel({
        this.id,
        this.patientId,
        this.reportType,
        this.fileUrl,
        this.fileFormat,
        this.reportDate,
        this.doctorName,
        this.labName,
        this.aiSummary,
        this.fileName,
        this.fileSize,
        this.notes,
        this.createdAt,
        this.updatedAt,
    });

    factory LabReportModel.fromJson(Map<String, dynamic> json) => LabReportModel(
        id: json["id"],
        patientId: json["patientId"],
        reportType: json["reportType"],
        fileUrl: json["fileUrl"],
        fileFormat: json["fileFormat"],
        reportDate: json["reportDate"] == null ? null : DateTime.parse(json["reportDate"]),
        doctorName: json["doctorName"],
        labName: json["labName"],
        aiSummary: json["aiSummary"],
        fileName: json["fileName"],
        fileSize: json["fileSize"],
        notes: json["notes"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        "reportType": reportType,
        "fileUrl": fileUrl,
        "fileFormat": fileFormat,
        "reportDate": "${reportDate!.year.toString().padLeft(4, '0')}-${reportDate!.month.toString().padLeft(2, '0')}-${reportDate!.day.toString().padLeft(2, '0')}",
        "doctorName": doctorName,
        "labName": labName,
        "aiSummary": aiSummary,
        "fileName": fileName,
        "fileSize": fileSize,
        "notes": notes,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
