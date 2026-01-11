import 'package:medidropbox/app/repository/lab_report/lab_report_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/mock_response_handler.dart';

class LabReportMocRepo extends BaseMockRepository implements LabReportRepo{
  @override
  Future<ApiModel> uploadLabReport( body) {
    throw UnimplementedError();
  }
  @override
  Future<ApiModel> getLabReport() {
    return mockResponse(status: true, message: "message",data: _labReportList);
  }
  
  @override
  Future<ApiModel> getLabReportById(String id) {
     return mockResponse(status: true, message: "message",data: _labMoc);

  }
}

var _labMoc =  {
        "id": 4,
        "patientId": 1,
        "reportType": "XRAY",
        "fileUrl": "https://shopdata2.s3.ap-south-1.amazonaws.com/reports/xray/1/f1170a87-2650-4d15-ab2c-a9f1fd0fe517.jpg",
        "fileFormat": "IMAGE",
        "reportDate": "2026-01-05",
        "doctorName": "Dr name",
        "labName": "red cliff",
        "aiSummary": "not found",
        "fileName": "d5950799ddb11fdc90b897369c82eec9.jpg",
        "fileSize": 85761,
        "notes": "that is human",
        "createdAt": "2026-01-05T22:53:54",
        "updatedAt": "2026-01-05T22:53:54"
    };


var _labReportList = [
    {
        "id": 4,
        "patientId": 1,
        "reportType": "XRAY",
        "fileUrl": "https://shopdata2.s3.ap-south-1.amazonaws.com/reports/xray/1/f1170a87-2650-4d15-ab2c-a9f1fd0fe517.jpg",
        "fileFormat": "IMAGE",
        "reportDate": "2026-01-05",
        "doctorName": "Dr name",
        "labName": "red cliff",
        "aiSummary": "not found",
        "fileName": "d5950799ddb11fdc90b897369c82eec9.jpg",
        "fileSize": 85761,
        "notes": "that is human",
        "createdAt": "2026-01-05T22:53:54",
        "updatedAt": "2026-01-05T22:53:54"
    },
    {
        "id": 1,
        "patientId": 1,
        "reportType": "XRAY",
        "fileUrl": "https://shopdata2.s3.ap-south-1.amazonaws.com/reports/xray/1/36be1c72-e877-4ecf-ac22-cab9ec30b5b2.jpeg",
        "fileFormat": "IMAGE",
        "reportDate": "2024-12-20",
        "doctorName": "Dr. Sharma",
        "labName": "Apollo Labs",
        "aiSummary": "No fracture detected. Mild swelling.",
        "fileName": "WhatsApp Image 2025-09-14 at 10.45.57 AM.jpeg",
        "fileSize": 10520,
        "notes": "Follow-up required",
        "createdAt": "2025-12-31T20:05:09",
        "updatedAt": "2025-12-31T20:05:09"
    },
  
];