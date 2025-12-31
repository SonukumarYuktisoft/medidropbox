import 'package:medidropbox/app/services/api_model.dart';

abstract class DoctorRepo {
  // Future<ApiModel> getAllDoctors(String hospital);
  // Future<ApiModel> getDoctorById(String id);
  Future<ApiModel> getAllDoctors(String id);
  Future<ApiModel> getAllDoctorsWithFiltterNoAuth(Map<String,dynamic> data);
  Future<ApiModel> getDoctorById(String id);
}
