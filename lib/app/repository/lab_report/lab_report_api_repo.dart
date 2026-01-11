import 'package:dio/dio.dart';
import 'package:medidropbox/app/repository/lab_report/lab_report_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class LabReportApiRepo  implements LabReportRepo{
  final ApiService network = ApiService();

  @override
  Future<ApiModel> uploadLabReport(FormData formData) async {
    try {
      final response = await network.requestPostWithFormData(
        url: AppConfig.uploadLabReport,
        authToken: true,
        formData: formData
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"Report uploaded Successfuly": "Unable to upload report. Please try again.",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<ApiModel> getLabReport() async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getLabReport,
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"Report uploaded Successfuly": "Unable to upload report. Please try again.",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<ApiModel> getLabReportById(String id)  async {
    try {
      final response = await network.requestGetForApi(
        url: "${AppConfig.getLabReportById}$id",
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"Report uploaded Successfuly": "Unable to upload report. Please try again.",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }
}