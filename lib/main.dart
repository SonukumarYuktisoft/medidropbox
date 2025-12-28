import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';
import 'package:medidropbox/core/utility/themes/app_theme.dart';
import 'package:medidropbox/core/utility/utility_screen/network/bloc/network_bloc.dart';
import 'package:medidropbox/navigator/app_blocs/app_blocs.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';
import 'package:medidropbox/navigator/injector/repo_locators.dart';
import 'package:medidropbox/navigator/routes/app_go_routes/app_routes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RepoLocators.locate(GetItEnvironment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocs.appBloc,
      child: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          // if (state.status == NetworkStatus.disconnected) {
          //   AppSnackbar.showError('No internet connection');
            
          // } else if (state.status == NetworkStatus.connected) {
          //   AppSnackbar.showSuccess('Connected to internet');
          // }
        },
        child: MaterialApp.router(
           scaffoldMessengerKey: AppKey.scaffoldMessengerKey,
          title: "MediDropBox",
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
