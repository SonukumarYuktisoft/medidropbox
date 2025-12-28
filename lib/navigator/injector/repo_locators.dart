import 'package:medidropbox/app/repository/doctors/doctor_api_repo.dart';
import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_api_repo.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_moc_repo.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';

class RepoLocators {
  static Future<void> locate(GetItEnvironment environment) async {
    switch (environment) {
      case GetItEnvironment.prod:
        AppKey.getIt.registerLazySingleton<HospitalRepo>(
          () => HospitalApiRepo(),
        );
        AppKey.getIt.registerLazySingleton<DoctorRepo>(
          () => DoctorApiRepo(),
        );
      default:
        AppKey.getIt.registerLazySingleton<HospitalRepo>(
          () => HospitalMocRepo(),
        );
        AppKey.getIt.registerLazySingleton<DoctorRepo>(
          () => DoctorApiRepo(),
        );
    }
  }
}
