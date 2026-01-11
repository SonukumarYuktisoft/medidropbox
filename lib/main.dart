import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';
import 'package:medidropbox/core/utility/themes/app_theme.dart';
import 'package:medidropbox/navigator/app_blocs/app_blocs.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';
import 'package:medidropbox/navigator/injector/repo_locators.dart';
import 'package:medidropbox/navigator/routes/app_go_routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥🔥🔥 THIS IS THE FIX987654321
  await RepoLocators.locate(GetItEnvironment.prod);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocs.appBloc,
      child: MaterialApp.router(
        scaffoldMessengerKey: AppKey.scaffoldMessengerKey,
        title: "MediDropBox",
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
