import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppKey {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey =GlobalKey<ScaffoldState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =GlobalKey<ScaffoldMessengerState>();
  static final GetIt getIt = GetIt.instance;
}
