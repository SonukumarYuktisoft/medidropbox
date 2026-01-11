import 'dart:developer';

import 'package:medidropbox/app/repository/health_profile/health_profile_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class HealthProfileApiRepo implements HealthProfileRepo{
    final ApiService network = ApiService();

  @override
  Future<ApiModel> createOrUpdateHealthProfile(Map<String, dynamic> body) async {
    try {
      final response = await network.requestPostForApi(
        url: AppConfig.createOrUpdateHealthProfile,
        authToken: true,
        dictParameter: body
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"Update health profile succesfuly" :"Update health profile geting error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> createVitalRecord(Map<String, dynamic> body) async {
    try {
      final response = await network.requestPostForApi(
        url: AppConfig.createVitalRecord,
        authToken: true,
        dictParameter: body
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"Vital record created succesfuly" :"Vital record geting error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> getBMIReport() async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getBMIReport,
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"BMI record succesfuly" :"BMI record geting error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> getHealthProfile() async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getHealthProfile,
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"Health profile geting succesfuly" :"Health profile geting error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> getLetestVital() async {
    try {
      final response = await network.requestGetForApi(
        url: AppConfig.getLatestVital,
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"geting latest vitals succesfuly" :"geting latest vitals error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> getVitalHistory(Map<String, dynamic> body) async {
    try {
      final response = await network.requestPostForApi(
        url: AppConfig.getVitalHistory,
        authToken: true,
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"geting vitals history succesfuly" :"geting vitals history error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiModel> updateVitalRecord(Map<String, dynamic> body,String vitalRecordId) async {
    try {
      final response = await network.requestPutForApi(
        url: AppConfig.updateVitalRecord(vitalRecordId),
        authToken: true,
        dictParameter: body
      );
      final bool isSuccess = (response != null && response.statusCode == 200);
      return ApiModel(
        status: isSuccess,
        message: isSuccess?"update vitals succesfuly" :"update vitals error",
        data: isSuccess ? response.data : null,
      );
    } catch (e) {
      rethrow;
    }
  }

}