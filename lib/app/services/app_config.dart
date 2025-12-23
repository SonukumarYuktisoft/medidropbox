class AppConfig {
//  String get baseUrl => 'http://10.0.2.2:8080';
 static const String  baseUrl = 'http://localhost:8080';
//String get baseUrl => 'http://192.168.31.70:8080';

  // 1. Registration & Authentication
  static const String  patientsRegister = '$baseUrl/api/v1/patients/register';
  static const String  generateOtp = '$baseUrl/api/v1/otp/generate';
  static const String  verifyOtpAndLogin = '$baseUrl/api/v1/otp/verify';

  // 2. Browse Hospitals 
  static const String  getAllHospitals = '$baseUrl/api/v1/hospitals';

}