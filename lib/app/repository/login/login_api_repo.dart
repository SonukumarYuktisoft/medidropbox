import 'package:medidropbox/core/helpers/app_export.dart';

class LoginApiRepo implements LoginRepo {
  final _api = NetworkServicesApi();
  @override
  Future<ApiResponse> loginApi(data) async {
    try {
      final res = await _api.postApi(AppUrls.login, data);
      final bool status = res['status'];
      final String mess = res['message'];
      return ApiResponse(
        message: mess,
        status: status,
        data: status ? res : null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
