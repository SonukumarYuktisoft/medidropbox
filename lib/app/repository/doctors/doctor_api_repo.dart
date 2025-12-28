import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class DoctorApiRepo implements DoctorRepo {
  final ApiService network = ApiService();

  @override
  Future<ApiModel> getAllDoctors(String id) async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getAllDoctorByHospitalPublicNoAuth(id),
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: "message",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> getDoctorById(String id) async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getDoctorByIdPublicNoAuth(id),
        authToken: false,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: "message",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
