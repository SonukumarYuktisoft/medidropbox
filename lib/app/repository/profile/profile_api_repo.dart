import 'package:medidropbox/app/repository/profile/profile_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class ProfileApiRepo implements ProfileRepo {
  final ApiService network = ApiService();
  @override
  Future<ApiModel> getProfile() async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getProfile,
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
  Future<ApiModel> updateProfile(data) async {
    try {
      final response = await network.requestPutForApi(
        url: AppConfig.editProfile,
        dictParameter: data,
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
