import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';

class RepoInjectors {
  static final loginRepo = AppKey.getIt<HospitalRepo>();
  static final doctorRepo = AppKey.getIt<DoctorRepo>();
}