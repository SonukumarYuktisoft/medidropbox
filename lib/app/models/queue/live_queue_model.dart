// To parse this JSON data, do
//
//     final liveQueueModel = liveQueueModelFromJson(jsonString);

import 'dart:convert';

LiveQueueModel liveQueueModelFromJson(String str) => LiveQueueModel.fromJson(json.decode(str));

String liveQueueModelToJson(LiveQueueModel data) => json.encode(data.toJson());

class LiveQueueModel {
    int? doctorId;
    String? doctorName;
    int? hospitalId;
    String? hospitalName;
    DateTime? bookingDate;
    dynamic currentServingQueueNumber;
    int? totalWaiting;
    dynamic estimatedWaitTime;
    List<Queue>? queues;

    LiveQueueModel({
        this.doctorId,
        this.doctorName,
        this.hospitalId,
        this.hospitalName,
        this.bookingDate,
        this.currentServingQueueNumber,
        this.totalWaiting,
        this.estimatedWaitTime,
        this.queues,
    });

    factory LiveQueueModel.fromJson(Map<String, dynamic> json) => LiveQueueModel(
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
        currentServingQueueNumber: json["currentServingQueueNumber"],
        totalWaiting: json["totalWaiting"],
        estimatedWaitTime: json["estimatedWaitTime"],
        queues: json["queues"] == null ? [] : List<Queue>.from(json["queues"]!.map((x) => Queue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "doctorName": doctorName,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "bookingDate": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "currentServingQueueNumber": currentServingQueueNumber,
        "totalWaiting": totalWaiting,
        "estimatedWaitTime": estimatedWaitTime,
        "queues": queues == null ? [] : List<dynamic>.from(queues!.map((x) => x.toJson())),
    };
}

class Queue {
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

    Queue({
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

    factory Queue.fromJson(Map<String, dynamic> json) => Queue(
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
