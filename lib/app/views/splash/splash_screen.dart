import 'package:get/utils.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/utility/utility_screen/network/bloc/network_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkConnectionAndNavigate();
  }

  Future<void> _checkConnectionAndNavigate() async {
    // Check network status first
    context.read<NetworkBloc>().add(CheckNetworkStatus());

    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final networkState = context.read<NetworkBloc>().state;

    if (networkState.isConnected) {
      AppNavigators.pushNamed(AppRoutesName.loginView);
    } else {
            AppNavigators.pushNamed(AppRoutesName.noInternetConnectionView);

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            'assets/images/app_logo.svg'.toAssetSvgImage(
              height:context.height * .2,
              width: MediaQuery.of(context).size.width * .2,
            ),
            // const FlutterLogo(size: 100),
            const SizedBox(height: 24),
            Text(
              'MediDropBox',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
