import 'package:medidropbox/app/services/api_model.dart';

abstract class HospitalRepo {
 Future<ApiModel>getAllHospitals();
 Future<ApiModel>getHospitalById(String id);
 Future<ApiModel>getHospitalByIdPublicNoAuth(String id);


}