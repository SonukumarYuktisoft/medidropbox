
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';

class HospitalApiRepo implements HospitalRepo{
    final ApiService network = ApiService();

  @override
  Future<ApiModel> getAllHospitals()async {
     try{
   final response = await network.requestGetForApi(
    url: AppConfig.getAllHospitals,authToken: true,);
      final bool isSuccess = (response!=null&& response.statusCode==200);
      return ApiModel(status: isSuccess, message: "message",data: isSuccess?response.data:null);
     }catch(e){
      rethrow;
     }
  }

  @override
  Future<ApiModel> getHospitalById(String id) {
    // TODO: implement getHospitalById
    throw UnimplementedError();
  }

  @override
  Future<ApiModel> getHospitalByIdPublicNoAuth(String id) {
    // TODO: implement getHospitalByIdPublicNoAuth
    throw UnimplementedError();
  }
}