import 'package:dio/dio.dart';
import 'package:medidropbox/app/services/api_model.dart';

abstract class LabReportRepo {
  Future<ApiModel> uploadLabReport(FormData body);
  Future<ApiModel> getLabReport();
  Future<ApiModel> getLabReportById(String id);
}