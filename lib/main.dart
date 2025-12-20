import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/core/navigators/NavigationState.dart';
import 'package:medidropbox/core/utility/themes/app_theme.dart';
import 'package:medidropbox/core/utility/utility_screen/network/bloc/network_bloc.dart';
import 'package:medidropbox/routes/app_pages.dart';
import 'package:medidropbox/routes/bloc_provider/app_blocs/app_blocs_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocsProvider.appBloc,
      child: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state.status == NetworkStatus.disconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No internet connection'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state.status == NetworkStatus.connected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Connected to internet'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: MaterialApp.router(
          title: "MediDropBox",
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
