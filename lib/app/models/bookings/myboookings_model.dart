// To parse this JSON data, do
//
//     final myBookings = myBookingsFromJson(jsonString);

import 'dart:convert';

List<MyBookings> myBookingsFromJson(String str) =>
    List<MyBookings>.from(json.decode(str).map((x) => MyBookings.fromJson(x)));

String myBookingsToJson(List<MyBookings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBookings {
  int? id;
  int? doctorId;
  String? doctorName;
  int? patientId;
  String? patientName;
  dynamic patientPhone;
  dynamic patientEmail;
  int? hospitalId;
  String? hospitalName;
  DateTime? bookingDate;
  String? bookingTime;
  String? phoneNumber;
  Queue? queue;
  Payment? payment;
  String? status;

  MyBookings({
    this.id,
    this.doctorId,
    this.doctorName,
    this.patientId,
    this.patientName,
    this.patientPhone,
    this.patientEmail,
    this.hospitalId,
    this.hospitalName,
    this.bookingDate,
    this.bookingTime,
    this.phoneNumber,
    this.queue,
    this.payment,
    this.status,
  });

  factory MyBookings.fromJson(Map<String, dynamic> json) => MyBookings(
    id: json["id"],
    doctorId: json["doctorId"],
    doctorName: json["doctorName"],
    patientId: json["patientId"],
    patientName: json["patientName"],
    patientPhone: json["patientPhone"],
    patientEmail: json["patientEmail"],
    hospitalId: json["hospitalId"],
    hospitalName: json["hospitalName"],
    bookingDate: json["bookingDate"] == null
        ? null
        : DateTime.parse(json["bookingDate"]),
    bookingTime: json["bookingTime"],
    phoneNumber: json["phoneNumber"],
    queue: json["queue"] == null ? null : Queue.fromJson(json["queue"]),
    payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctorId": doctorId,
    "doctorName": doctorName,
    "patientId": patientId,
    "patientName": patientName,
    "patientPhone": patientPhone,
    "patientEmail": patientEmail,
    "hospitalId": hospitalId,
    "hospitalName": hospitalName,
    "bookingDate":
        "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
    "bookingTime": bookingTime,
    "phoneNumber": phoneNumber,
    "queue": queue?.toJson(),
    "payment": payment?.toJson(),
    "status": status,
  };
}

class Payment {
  int? id;
  String? paymentMode;
  double? totalBill;
  double? totalAmount;
  double? discount;
  double? taxableAmount;
  double? gst;
  String? transactionId;

  Payment({
    this.id,
    this.paymentMode,
    this.totalBill,
    this.totalAmount,
    this.discount,
    this.taxableAmount,
    this.gst,
    this.transactionId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    paymentMode: json["paymentMode"],
    totalBill: (json["totalBill"] as num?)?.toDouble(),
    totalAmount: (json["totalAmount"] as num?)?.toDouble(),
    discount: (json["discount"] as num?)?.toDouble(),
    taxableAmount: (json["taxableAmount"] as num?)?.toDouble(),
    gst: (json["gst"] as num?)?.toDouble(),
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paymentMode": paymentMode,
    "totalBill": totalBill,
    "totalAmount": totalAmount,
    "discount": discount,
    "taxableAmount": taxableAmount,
    "gst": gst,
    "transactionId": transactionId,
  };
}

class Queue {
  int? id;
  int? queueNumber;
  String? status;

  Queue({this.id, this.queueNumber, this.status});

  factory Queue.fromJson(Map<String, dynamic> json) => Queue(
    id: json["id"],
    queueNumber: json["queueNumber"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "queueNumber": queueNumber,
    "status": status,
  };
}
