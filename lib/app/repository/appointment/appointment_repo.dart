import 'package:medidropbox/app/services/api_model.dart';

abstract class AppointmentRepo {
  Future<ApiModel> getAppointment();
  Future<ApiModel> getAppointmentByid(String id);
  Future<ApiModel> createAppointment(Map<String, dynamic> data);
}
