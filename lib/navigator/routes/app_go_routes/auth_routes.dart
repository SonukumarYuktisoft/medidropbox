import 'package:go_router/go_router.dart';
import 'package:medidropbox/app/views/splash/splash_screen.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';
import 'package:medidropbox/app/auth/LoginScreen/login_screen.dart';


class AuthRoutes {
 static List<RouteBase> route =[
     GoRoute(
        path: AppRoutesPath.login,
        name: AppRoutesName.loginView,
        builder: (context, state) => const PhoneLoginScreen(),
      ),
      GoRoute(
        path: AppRoutesPath.splash,
        name: AppRoutesName.splashView,
        builder: (context, state) =>  SplashScreen(),
      ),
  ];
}