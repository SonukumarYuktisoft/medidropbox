class ApiModel {
  final bool status;
  final String message;
  final dynamic data;

  ApiModel({required this.status, required this.message, this.data});
}