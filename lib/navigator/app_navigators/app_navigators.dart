import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';
import 'package:medidropbox/navigator/routes/app_go_routes/app_routes.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';


class AppNavigators {
  // Get GoRouter instance
  static GoRouter get _router =>AppRouter.router;
  

  // Basic navigation methods using route names
  static void goNamed(String routeName, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters, Object? extra}) {
    _router.goNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static void go(String path, {Object? extra}) {
    _router.go(path, extra: extra);
  }

  static Future<T?> pushNamed<T>(String routeName, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters, Object? extra}) {
    return _router.pushNamed<T>(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static Future<T?> push<T>(String path, {Object? extra}) {
    return _router.push<T>(path, extra: extra);
  }

  // Pop methods
  static void pop<T extends Object?>([T? result]) {
    _router.pop(result);
  }

  static bool canPop() {
    return _router.canPop();
  }

  // Replace methods
  static void replaceNamed(String routeName, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters, Object? extra}) {
    _router.replaceNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static void replace(String path, {Object? extra}) {
    _router.replace(path, extra: extra);
  }

  // Push replacement
  static Future<T?> pushReplacementNamed<T>(String routeName, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters, Object? extra}) {
    return _router.pushReplacementNamed<T>(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static Future<T?> pushReplacement<T>(String path, {Object? extra}) {
    return _router.pushReplacement<T>(path, extra: extra);
  }

  // Root navigation methods
  static void goToRoot(String routeName, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters, Object? extra}) {
    // Pop all routes and go to specified route
    while (_router.canPop()) {
      _router.pop();
    }
    _router.goNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static void goToSplash() {
    goToRoot(AppRoutesName.splashView);
  }

  static void goToDashboard() {
    goNamed(AppRoutesName.dashboardView);
  }

  static void goToProfile() {
    goNamed(AppRoutesName.profileView);
  }

  // Pop to root
  static void popToRoot() {
    while (_router.canPop()) {
      _router.pop();
    }
  }

  // Utility methods
  static String get currentLocation {
    return _router.routerDelegate.currentConfiguration.uri.toString();
  }

  static String? get currentRouteName {
    final RouteMatchList matchList = _router.routerDelegate.currentConfiguration;
    if (matchList.matches.isNotEmpty) {
      final RouteBase route = matchList.matches.last.route;
      // Check if route is GoRoute and has name
      if (route is GoRoute) {
        return route.name;
      }
    }
    return null;
  }

  static bool isAtRoot() {
    return !_router.canPop();
  }

  // Focus management
  static void unfocus() {
    if (AppKey.navigatorKey.currentContext != null) {
      FocusScope.of(AppKey.navigatorKey.currentContext!).unfocus();
    }
  }

  // Dialog methods (these still need context from navigatorKey)
  static Future<T?> showDialogRoute<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    if (AppKey.navigatorKey.currentContext == null) {
      throw Exception('Navigator context is null');
    }
    return showDialog<T>(
      context: AppKey.navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  static Future<T?> showBottomSheetRoute<T>({
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    if (AppKey.navigatorKey.currentContext == null) {
      throw Exception('Navigator context is null');
    }
    return showModalBottomSheet<T>(
      context: AppKey.navigatorKey.currentContext!,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: builder,
    );
  }

  static void showSnackBar(String message, {Duration? duration}) {
    if (AppKey.navigatorKey.currentContext == null) {
      throw Exception('Navigator context is null');
    }
    ScaffoldMessenger.of(AppKey.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  // Refresh current route
  static void refresh() {
    _router.refresh();
  }
}