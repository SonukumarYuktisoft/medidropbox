import 'package:medidropbox/app/data/network/api_response_model.dart';

abstract class LoginRepo {
  Future<ApiResponse> loginApi(dynamic data);
}
