// To parse this JSON data, do
//
//     final myQueueModel = myQueueModelFromJson(jsonString);

import 'dart:convert';

List<MyQueueModel> myQueueModelFromJson(String str) => List<MyQueueModel>.from(json.decode(str).map((x) => MyQueueModel.fromJson(x)));

String myQueueModelToJson(List<MyQueueModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyQueueModel {
    int? id;
    DateTime? bookingDate;
    int? doctorId;
    String? doctorName;
    int? patientId;
    String? patientName;
    dynamic patientPhone;
    int? queueNumber;
    String? status;
    int? bookingId;
    dynamic estimatedWaitTime;

    MyQueueModel({
        this.id,
        this.bookingDate,
        this.doctorId,
        this.doctorName,
        this.patientId,
        this.patientName,
        this.patientPhone,
        this.queueNumber,
        this.status,
        this.bookingId,
        this.estimatedWaitTime,
    });

    factory MyQueueModel.fromJson(Map<String, dynamic> json) => MyQueueModel(
        id: json["id"],
        bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        patientId: json["patientId"],
        patientName: json["patientName"],
        patientPhone: json["patientPhone"],
        queueNumber: json["queueNumber"],
        status: json["status"],
        bookingId: json["bookingId"],
        estimatedWaitTime: json["estimatedWaitTime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bookingDate": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "doctorId": doctorId,
        "doctorName": doctorName,
        "patientId": patientId,
        "patientName": patientName,
        "patientPhone": patientPhone,
        "queueNumber": queueNumber,
        "status": status,
        "bookingId": bookingId,
        "estimatedWaitTime": estimatedWaitTime,
    };
}
