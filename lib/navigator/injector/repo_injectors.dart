import 'package:medidropbox/app/repository/appointment/appointment_repo.dart';
import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/repository/health_profile/health_profile_repo.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/app/repository/lab_report/lab_report_repo.dart';
import 'package:medidropbox/app/repository/profile/profile_repo.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';

class RepoInjectors {
  static final hospitalRepo = AppKey.getIt<HospitalRepo>();
  static final doctorRepo = AppKey.getIt<DoctorRepo>();
   static final profile = AppKey.getIt<ProfileRepo>();
  static final appointmentRepo = AppKey.getIt<AppointmentRepo>();
  static final labReport = AppKey.getIt<LabReportRepo>();
  static final healthProfileReport = AppKey.getIt<HealthProfileRepo>();
}
