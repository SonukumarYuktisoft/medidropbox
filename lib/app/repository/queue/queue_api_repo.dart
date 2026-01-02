import 'package:medidropbox/app/repository/queue/queue_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class QueueApiRepo implements QueueRepo {
  final ApiService network = ApiService();

  @override
  Future<ApiModel> getLiveQueueDoctor(
    String doctorId) async {
    try {
      final response = await network.requestGetForApi(
        url:AppConfig.getLiveQueueForDoctor(doctorId),
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
  Future<ApiModel> getMyQueues() async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getMyQueues,
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
  Future<ApiModel> getLiveQueueForDoctorPublicNoAuth(
    String doctorId) async {
    try {
      final response = await network.requestGetForApi(
        url:
            AppConfig.getLiveQueueForDoctorPublicNoAuth ,

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
