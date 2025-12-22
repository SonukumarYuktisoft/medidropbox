

class ApiResponse {
  final bool status;
  final String message;
  dynamic data;
  ApiResponse({required this.status, required this.message, this.data});
}
