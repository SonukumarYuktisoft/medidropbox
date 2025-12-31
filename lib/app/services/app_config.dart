class AppConfig {
   static const String baseUrl = 'http://10.0.2.2:8080';

 //static const String baseUrl = 'http://192.168.1.5:8080';


  // 1. Registration & Authentication
  static const String patientsRegister = '$baseUrl/api/v1/patients/register';
  static const String generateOtp = '$baseUrl/api/v1/otp/generate';
  static const String verifyOtpAndLogin = '$baseUrl/api/v1/otp/verify';
  // static const String patientsRegister = '$baseUrl/api/v1/patients/register';
  // static const String generateOtp = '$baseUrl/api/v1/otp/generate';
  // static const String verifyOtpAndLogin = '$baseUrl/api/v1/otp/verify';

  // // 2. Browse Hospitals
  // static const String getAllHospitals = '$baseUrl/api/v1/hospitals';

  //get profile & update Profile
  static const String getProfile = '$baseUrl/api/v1/patients/me';
  static const String editProfile = '$baseUrl/api/v1/patients/me'; //put api
  //bookings
  static const String createBooking = '$baseUrl/api/v1/bookings'; //post api
  static const String getBooking = '$baseUrl/api/v1/bookings/my-bookings';
  static const String getBookingByid = '$baseUrl/api/v1/my-bookings/';
  // doctoer queues
  static const String getMyqueues = '$baseUrl/api/v1/queues/my-queues';
  static const String getMyDoctorQueues =
      '$baseUrl/api/v1/queues/live/doctor/{{doctorId}}?date=2024-12-25';
  static const String getPublicDoctorQueues =
      '$baseUrl/api/v1/queues/live/doctor/{{doctorId}}/public?date=2024-12-25';
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
