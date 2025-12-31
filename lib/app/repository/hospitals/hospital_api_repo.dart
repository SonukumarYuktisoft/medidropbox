import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class HospitalApiRepo implements HospitalRepo {
  final ApiService network = ApiService();

  @override
  Future<ApiModel> getAllHospitals({
    int page = 0,
    int size = 10,
    Map<String, dynamic>? filters,
  }) async {
    try {
      // Build query parameters
      final Map<String, dynamic> queryParams = {
        'page': page,
        'size': size,
      };

      // Add filters if provided
      if (filters != null) {
        if (filters['state'] != null) queryParams['state'] = filters['state'];
        if (filters['city'] != null) queryParams['city'] = filters['city'];
        if (filters['pincode'] != null) queryParams['pincode'] = filters['pincode'];
        if (filters['emergencyAvailable'] != null) {
          queryParams['emergencyAvailable'] = filters['emergencyAvailable'];
        }
        if (filters['isActive'] != null) queryParams['isActive'] = filters['isActive'];
        if (filters['is24x7'] != null) queryParams['is24x7'] = filters['is24x7'];
        if (filters['hasAmbulance'] != null) {
          queryParams['hasAmbulance'] = filters['hasAmbulance'];
        }
        if (filters['search'] != null && filters['search'].toString().isNotEmpty) {
          queryParams['search'] = filters['search'];
        }
        if (filters['latitude'] != null) queryParams['latitude'] = filters['latitude'];
        if (filters['longitude'] != null) queryParams['longitude'] = filters['longitude'];
        if (filters['radius'] != null) queryParams['radius'] = filters['radius'];
      }

      final response = await network.requestGetForApi(
        url: AppConfig.getAllHospitals,
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

  @override
  Future<ApiModel> getHospitalById(String id) async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getHospitalsById(id),
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"getHospitalsById Success":"getHospitalsById error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> getHospitalByIdPublicNoAuth(String id) async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getAllHospitalsByIdNoAuth(id),
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
}