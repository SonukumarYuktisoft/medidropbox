import 'package:medidropbox/app/repository/appointment/appointment_repo.dart';

import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/mock_response_handler.dart';

class AppointmentMocRepo extends BaseMockRepository implements AppointmentRepo {
  @override
  Future<ApiModel> createAppointment(Map<String, dynamic> data) {
    // TODO: implement getAppointment
    throw UnimplementedError();
  }

  @override
  Future<ApiModel> getAppointment() {
    return mockResponse(
      status: true,
      message: 'message',
      data: _appointmentMoc,
    );
  }

  @override
  Future<ApiModel> getAppointmentByid(String id) {
    // TODO: implement getAppointmentByid
    throw UnimplementedError();
  }
}

var _appointmentMoc = [
  {
    "id": 4,
    "doctorId": 1,
    "doctorName": "Dr. Jane Doe Updated",
    "patientId": 6,
    "patientName": "John Doe",
    "patientPhone": null,
    "patientEmail": null,
    "hospitalId": 1,
    "hospitalName": "City General Hospital",
    "bookingDate": "2024-12-25",
    "bookingTime": "10:00:00",
    "phoneNumber": "+91-9876543210",
    "queue": {"id": 1, "queueNumber": 1, "status": "WAITING"},
    "payment": {
      "id": 4,
      "paymentMode": "UPI",
      "totalBill": 1500.00,
      "totalAmount": 1500.00,
      "discount": 0.00,
      "taxableAmount": 1350.00,
      "gst": 150.00,
      "transactionId": "TXN1234567890UPI",
    },
    "status": "CONFIRMED",
  },
  {
    "id": 11,
    "doctorId": 1,
    "doctorName": "Dr. Jane Doe Updated",
    "patientId": 6,
    "patientName": "John Doe",
    "patientPhone": null,
    "patientEmail": null,
    "hospitalId": 1,
    "hospitalName": "City General Hospital",
    "bookingDate": "2024-12-25",
    "bookingTime": "10:00:00",
    "phoneNumber": "+91-9876543210",
    "queue": {"id": 8, "queueNumber": 2, "status": "WAITING"},
    "payment": {
      "id": 7,
      "paymentMode": "UPI",
      "totalBill": 1500.00,
      "totalAmount": 1500.00,
      "discount": 0.00,
      "taxableAmount": 1350.00,
      "gst": 150.00,
      "transactionId": "TXN1234567890UPI",
    },
    "status": "CONFIRMED",
  },
  {
    "id": 12,
    "doctorId": 1,
    "doctorName": "Dr. Jane Doe Updated",
    "patientId": 6,
    "patientName": "John Doe",
    "patientPhone": null,
    "patientEmail": null,
    "hospitalId": 1,
    "hospitalName": "City General Hospital",
    "bookingDate": "2024-12-25",
    "bookingTime": "10:00:00",
    "phoneNumber": "+91-9876543210",
    "queue": {"id": 9, "queueNumber": 3, "status": "WAITING"},
    "payment": {
      "id": 8,
      "paymentMode": "UPI",
      "totalBill": 1500.00,
      "totalAmount": 1500.00,
      "discount": 0.00,
      "taxableAmount": 1350.00,
      "gst": 150.00,
      "transactionId": "TXN1234567890UPI",
    },
    "status": "CONFIRMED",
  },
];
