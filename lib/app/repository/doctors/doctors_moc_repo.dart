import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';
import 'package:medidropbox/app/services/mock_response_handler.dart';

class DoctorsMocRepo extends BaseMockRepository  implements DoctorRepo {
  final ApiService network = ApiService();

  @override
  Future<ApiModel> getAllDoctorsByHospital(String hospital) async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getAllDoctorsByHospital(hospital),
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
  Future<ApiModel> getDoctorByHospitalPublicNoAuth(String id) async {
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
        url: AppConfig.getDoctorById(id),
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
  Future<ApiModel> getDoctorByIdPublicNoAuth(String id) async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getDoctorByIdPublicNoAuth(id),
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
  Future<ApiModel> getAllDoctors(String hospital) {
    // TODO: implement getAllDoctors
    throw UnimplementedError();
  }
}
