import 'package:medidropbox/app/services/api_model.dart';

abstract class HealthProfileRepo {
  Future<ApiModel>getHealthProfile();
  Future<ApiModel>createOrUpdateHealthProfile(Map<String,dynamic>body);
  Future<ApiModel>createVitalRecord(Map<String,dynamic>body);
  Future<ApiModel>updateVitalRecord(Map<String,dynamic>body,String vitalRecordId);
  Future<ApiModel>getLetestVital();
  Future<ApiModel>getVitalHistory(Map<String,dynamic>body);
  Future<ApiModel>getBMIReport();
}