
import 'package:medidropbox/app/repository/health_profile/health_profile_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/mock_response_handler.dart';

class HealthProfileMocRepo extends BaseMockRepository implements HealthProfileRepo{
  @override
  Future<ApiModel> createOrUpdateHealthProfile(Map<String, dynamic> body) {
  return mockResponse(status: true, message: "message",data: _createOrUpdateMoc);
  }

  @override
  Future<ApiModel> createVitalRecord(Map<String, dynamic> body) {
  return mockResponse(status: true, message: "message",data: _createVitalsRecord);

  }

  @override
  Future<ApiModel> getBMIReport() {
      return mockResponse(status: true, message: "message",data: getBMIReportMoc);

  }

  @override
  Future<ApiModel> getHealthProfile() {
      return mockResponse(status: true, message: "message",data: _getProfileMoc);

  }

  @override
  Future<ApiModel> getLetestVital() {
  return mockResponse(status: true, message: "message",data: getLatestVitals);

  }

  @override
  Future<ApiModel> getVitalHistory(Map<String, dynamic> body) {
     return mockResponse(status: true, message: "message",data: getVitalHistoryMoc);

  }

  @override
  Future<ApiModel> updateVitalRecord(Map<String, dynamic> body,String vitalRecordId) {
    // TODO: implement updateVitalRecord
    throw UnimplementedError();
  }
}

var getVitalHistoryMoc = [
    {
        "id": 6,
        "globalPatientId": 4,
        "weightKg": 75.5,
        "bloodGlucoseMgdl": 90.0,
        "bloodPressureSystolic": 190,
        "bloodPressureDiastolic": 88,
        "bloodPressureDisplay": "190/88",
        "recordedAt": "2026-01-09T11:03:00",
        "notes": "Morning vitals check",
        "createdAt": "2026-01-08T23:32:15",
        "updatedAt": "2026-01-08T23:32:15"
    },
    {
        "id": 5,
        "globalPatientId": 4,
        "weightKg": 75.5,
        "bloodGlucoseMgdl": 95.0,
        "bloodPressureSystolic": 120,
        "bloodPressureDiastolic": 80,
        "bloodPressureDisplay": "120/80",
        "recordedAt": "2026-01-08T11:03:00",
        "notes": "Morning vitals check",
        "createdAt": "2026-01-08T23:23:34",
        "updatedAt": "2026-01-08T23:23:34"
    },
    {
        "id": 4,
        "globalPatientId": 4,
        "weightKg": 75.5,
        "bloodGlucoseMgdl": 95.0,
        "bloodPressureSystolic": 120,
        "bloodPressureDiastolic": 80,
        "bloodPressureDisplay": "120/80",
        "recordedAt": "2026-01-07T11:03:00",
        "notes": "Morning vitals check",
        "createdAt": "2026-01-07T23:05:46",
        "updatedAt": "2026-01-07T23:05:46"
    }
];
var getLatestVitals = {
    "latestWeight": 75.5,
    "latestWeightDate": "2026-01-07T11:03:00",
    "latestBloodGlucose": 95.0,
    "latestBloodGlucoseDate": "2026-01-07T11:03:00",
    "latestBloodPressureSystolic": 120,
    "latestBloodPressureDiastolic": 80,
    "latestBloodPressureDisplay": "120/80",
    "latestBloodPressureDate": "2026-01-07T11:03:00",
    "bmi": 24.65,
    "bmiCategory": "Normal",
    "bmiQuote": "A healthy body is a happy body. You're on the right track!",
    "disclaimer": "This data is patient-entered and is for tracking purposes only. It should not be used as a substitute for professional medical advice, diagnosis, or treatment."
};
var _getProfileMoc={
    "id": 2,
    "globalPatientId": 4,
    "heightCm": 175.0,
    "bloodGroup": "A_POSITIVE",
    "gender": "MALE",
    "dateOfBirth": "1990-05-15",
    "createdAt": "2026-01-07T23:08:02",
    "updatedAt": "2026-01-07T23:08:02"
};

var getBMIReportMoc ={
    "bmi": 24.65,
    "bmiCategory": "Normal",
    "bmiDescription": "Congratulations! Your BMI is within the healthy range. Keep maintaining your healthy lifestyle.",
    "inspirationalQuote": "A healthy body is a happy body. You're on the right track!",
    "heightCm": 175.0,
    "weightKg": 75.5,
    "weightRecordedAt": "2026-01-07T11:03:00",
    "healthRecommendation": "Maintain your current healthy habits: balanced diet, regular exercise, and adequate sleep.",
    "disclaimer": "This BMI calculation is based on patient-entered data and is for tracking purposes only. BMI is a screening tool and does not diagnose health conditions. Please consult with a healthcare professional for medical advice, diagnosis, or treatment."
};

var _createVitalsRecord = {
    "id": 4,
    "globalPatientId": 4,
    "weightKg": 75.5,
    "bloodGlucoseMgdl": 95.0,
    "bloodPressureSystolic": 120,
    "bloodPressureDiastolic": 80,
    "bloodPressureDisplay": "120/80",
    "recordedAt": "2026-01-07T11:03:00",
    "notes": "Morning vitals check",
    "createdAt": "2026-01-07T23:05:46.592302",
    "updatedAt": "2026-01-07T23:05:46.592302"
};

var _createOrUpdateMoc = {
    "id": 2,
    "globalPatientId": 4,
    "heightCm": 175.0,
    "bloodGroup": "A_POSITIVE",
    "gender": "MALE",
    "dateOfBirth": "1990-05-15",
    "createdAt": "2026-01-07T23:08:02.337345",
    "updatedAt": "2026-01-07T23:08:02.337345"
};