import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medidropbox/routes/app_routes.dart';

class RoutesService {

  static void toLogin () {
    Get.toNamed(AppRoutes.loginScreen);
  }

   static void toDashboard () {
    Get.toNamed(AppRoutes.dashboardScreen);
  }
  
  static void toBottomNavigationScreen () {
    Get.offAllNamed(AppRoutes.bottomNavigationScreen);
  }
  
  
} 