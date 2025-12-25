import 'package:medidropbox/app/repository/appointment/appointment_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class AppointmentApiRepo implements AppointmentRepo {
  final ApiService network = ApiService();
  @override
  @override
  Future<ApiModel> createAppointment(Map<String, dynamic> data) async {
    try {
      final response = await network.requestPostForApi(
        url: AppConfig.createBooking,
        authToken: true,
        dictParameter: data,
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
  Future<ApiModel> getAppointment() async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getBooking,
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
  Future<ApiModel> getAppointmentByid(String id) async {
    try {
      final response = await network.requestGetForApi(
        url: "${AppConfig.getBookingByid}$id",
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
