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
  
  @override
  Future<ApiModel> getAllDoctorsWithFiltterNoAuth(Map<String, dynamic> filters) async {
    try {
        // Build query parameters
        final Map<String, dynamic> queryParams = {};
        if (filters['search'] != null) queryParams['search'] = filters['search'];
        if (filters['specialty'] != null) queryParams['specialty'] = filters['specialty'];
        if (filters['minRating'] != null) queryParams['minRating'] = filters['minRating'];
        if (filters['maxRating'] != null) {
          queryParams['maxRating'] = filters['maxRating'];
        }
        if (filters['isActive'] != null) queryParams['isActive'] = filters['isActive'];
        if (filters['minFees'] != null) queryParams['minFees'] = filters['minFees'];
        if (filters['page'] != null) queryParams['page'] = filters['page'];
        if (filters['size'] != null) queryParams['size'] = filters['size'];
        if (filters['maxFees'] != null) {
          queryParams['maxFees'] = filters['maxFees'];
        }
        if (filters['allowRemote'] != null && filters['allowRemote'].toString().isNotEmpty) {
          queryParams['allowRemote'] = filters['allowRemote'];
        }
        
      final response = await network.requestGetForApi(
        url: AppConfig.getAllDoctorsWithFiltterNoAuth,
        authToken: true,
        dictParameter: queryParams,
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
