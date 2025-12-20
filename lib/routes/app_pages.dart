import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medidropbox/core/utility/utility_screen/error_screen.dart';
import 'package:medidropbox/view/features/DashboardScreen/dashboard_screen.dart';
import 'package:medidropbox/view/features/OnboardingScreen/view/onboarding_screen.dart';
import 'package:medidropbox/view/features/ProfileScreen/profile_screen.dart';
import 'package:medidropbox/view/features/SettingsScreen/settings_screen.dart';
import 'package:medidropbox/view/features/auth/LoginScreen/login_screen.dart';
import 'package:medidropbox/view/features/auth/SignupScreen/signup_screen.dart';
import 'package:medidropbox/view/features/auth/forget_screen/view/forget_screen.dart';
import 'package:medidropbox/view/features/bottom_navigation_screen.dart';
import 'package:medidropbox/view/features/splash/splash_screen.dart';
import 'package:medidropbox/core/utility/utility_screen/not_network_screen.dart';
import 'app_routes.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,

  debugLogDiagnostics: false, // production = false

  errorBuilder: (context, state) {
    return ErrorScreen(error: state.error);
  },

  // redirect: (context, state) {
  //   final isLoggedIn = AuthService.isLoggedIn; // shared pref / token
  //   final isSplash = state.matchedLocation == AppRoutes.splash;
  //   final isLogin = state.matchedLocation == AppRoutes.loginScreen;

  //   if (!isLoggedIn && !isLogin && !isSplash) {
  //     return AppRoutes.loginScreen;
  //   }

  //   if (isLoggedIn && isLogin) {
  //     return AppRoutes.bottomNavigationScreen;
  //   }

  //   return null;
  // },

  routes: [

    /// Splash
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => SplashScreen(),
    ),

    /// Onboarding
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => OnboardingScreen(), // TODO
    ),

    /// Login
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => LoginScreen(),
    ),
 /// Singup
    GoRoute(
      path: AppRoutes.signupScreen,
      builder: (context, state) =>SignupScreen(),
    ),
     /// forget password
    GoRoute(
      path: AppRoutes.forgetScreen,
      builder: (context, state) =>ForgotPasswordScreen(),
    ),
    /// No Internet
    GoRoute(
      path: AppRoutes.noInternetConnection,
      builder: (context, state) => NoInternetScreen(),
    ),

    /// Bottom Navigation (ShellRoute)
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavigationScreen(child: child);
      },
      routes: [

        GoRoute(
          path: AppRoutes.dashboardScreen,
          builder: (context, state) => DashboardScreen(),
        ),

        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => ProfileScreen(),
        ),

        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => SettingsScreen(),
        ),
      ],
    ),
  ],
);
