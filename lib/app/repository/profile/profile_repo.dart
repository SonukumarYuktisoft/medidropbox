import 'package:medidropbox/app/services/api_model.dart';

abstract class ProfileRepo {
  Future<ApiModel> getProfile();
  Future<ApiModel> updateProfile(Map<String, dynamic> data);
}
