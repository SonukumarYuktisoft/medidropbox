class AppConfig {
  //  static const  String  baseUrl = 'http://10.0.2.2:8080';
  //  static const String  baseUrl = 'http://localhost:8080';
  static const String baseUrl = 'http://10.202.111.46:8080';

  // 1. Registration & Authentication
  static const String patientsRegister = '$baseUrl/api/v1/patients/register';
  static const String generateOtp = '$baseUrl/api/v1/otp/generate';
  static const String verifyOtpAndLogin = '$baseUrl/api/v1/otp/verify';

  //2. Browse Hospitals
  static const String getAllHospitals = '$baseUrl/api/v1/hospitals';
  static  String getHospitalsById (String hospitalId) => '$baseUrl/api/v1/hospitals/$hospitalId';
  static  String getAllHospitalsByIdNoAuth (String hospitalId) => '$baseUrl/api/v1/hospitals/$hospitalId/public';


  // 3. Browse Doctors
   static  String getAllDoctorsByHospital(String hospital) => '$baseUrl/api/v1/doctors/$hospital';
   static  String getAllDoctorByHospitalPublicNoAuth(String hospital) => '$baseUrl/api/v1/doctors/hospital/$hospital/public';
   static  String getDoctorById(String doctorId) => '$baseUrl/api/v1/doctors/$doctorId';
   static  String getDoctorByIdPublicNoAuth(String doctorId) => '$baseUrl/api/v1/doctors/$doctorId/public';

  //  6. Queue Management
  static const String getMyQueues = '$baseUrl/api/v1/queues/my-queues';
  static const String getLiveQueueForDoctor = '$baseUrl/api/v1/queues/live/doctor/';
  static const String getLiveQueueForDoctorPublicNoAuth = '$baseUrl/api/v1/queues/live/doctor/';
  

}
