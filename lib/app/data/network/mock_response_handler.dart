
import 'package:medidropbox/app/data/network/api_response_model.dart';

class BaseMockRepository {
  Future<ApiResponse> mockResponse({
    required bool status,
    required String message,
    dynamic data,
    Duration delay = const Duration(milliseconds: 300),
  }) async {
    await Future.delayed(delay);
    return ApiResponse(status: status, message: message, data: data);
  }
}
