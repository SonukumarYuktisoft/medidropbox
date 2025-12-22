
import 'package:medidropbox/app/services/api_model.dart';

class BaseMockRepository {
  Future<ApiModel> mockResponse({
    required bool status,
    required String message,
    dynamic data,
    Duration delay = const Duration(milliseconds: 300),
  }) async {
    await Future.delayed(delay);
    return ApiModel(status: status, message: message, data: data);
  }
}
