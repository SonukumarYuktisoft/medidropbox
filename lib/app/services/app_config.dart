class AppConfig {
String get baseUrl => 'http://10.0.2.2:8080';

  // 1. Registration & Authentication
  String get patientsRegister => '$baseUrl/api/v1/patients/register';
  String get generateOtp => '$baseUrl/api/v1/otp/generate';
  String get verifyOtpAndLogin => '$baseUrl/api/v1/otp/verify';

  // 2. Browse Hospitals
  String get getAllHospitals => '$baseUrl/api/v1/hospitals';
  String getHospitalById(String hospitalId) => '$baseUrl/api/v1/hospitals/$hospitalId';

  // 3. Browse Doctors
  String get getAllDoctors => '$baseUrl/api/v1/doctors';
  String getDoctorById(String doctorId) => '$baseUrl/api/v1/doctors/$doctorId';
}