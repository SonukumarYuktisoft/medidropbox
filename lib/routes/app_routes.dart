class AppRoutes {
  // Authentication Routes
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/signup_screen';
  static const String forgetScreen = '/forget-password';
  static const String verifyEmail = '/verify-email';

  // Main App Routes
  static const String bottomNavigationScreen = '/bottom_navigation';
  static const String dashboardScreen = '/dashboard_screen';
  static const String profile = '/profile';
  static const String settings = '/settings';


  // Error Routes
  static const String noInternetConnection = '/no-internet-connection';
  static const String notFound = '/404';
  static const String error = '/error';

  // Get all routes as a list for easy reference
  static List<String> get allRoutes => [
    splash,
    onboarding,
    loginScreen,
    signupScreen,
    forgetScreen,
    verifyEmail,
    dashboardScreen,
    profile,
    settings,
    notFound,
    error,
  ];
}
