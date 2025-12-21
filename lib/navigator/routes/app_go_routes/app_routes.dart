import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';
import 'package:medidropbox/navigator/routes/app_go_routes/auth_routes.dart';
import 'package:medidropbox/navigator/routes/app_go_routes/dashboard_routes.dart';
import 'package:medidropbox/navigator/routes/app_go_routes/order_routes.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';

// Router Configuration
class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: AppKey.navigatorKey,
    initialLocation: AppRoutesPath.splash,
    debugLogDiagnostics: true,
    // Redirect logic (optional)
    // redirect: (BuildContext context, GoRouterState state) {
    //   // Example: Authentication check
    //   // final bool isLoggedIn = authService.isLoggedIn;
    //   // if (!isLoggedIn && state.location != AppRoutes.splash) {
    //   //   return AppRoutes.splash;
    //   // }
    //   return null; // No redirect
    // },
   
    // Routes
    routes: [
      ...OrderRoutes.route,
      ...AuthRoutes.route, 
      ...DashboardRoutes.route, 
     
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );

  // Helper method to get current location
  static String get currentLocation =>
      router.routerDelegate.currentConfiguration.uri.toString();
}

// Error Screen
class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Route Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(error?.toString() ?? 'Unknown error'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoutesName.splashView),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
