import 'package:medidropbox/app/services/api_model.dart';

abstract class HospitalRepo {
  Future<ApiModel> getAllHospitals({int page = 0,int size = 10,Map<String, dynamic>? filters,
  });
  
  Future<ApiModel> getHospitalById(String id);
  Future<ApiModel> getHospitalByIdPublicNoAuth(String id);
}