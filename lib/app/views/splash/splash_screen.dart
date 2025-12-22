import 'package:medidropbox/app/services/shared_preferences_helper.dart';
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

    // Wait for 3 seconds (splash screen display time)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final networkState = context.read<NetworkBloc>().state;

    // Check network connection
    if (!networkState.isConnected) {
      AppNavigators.pushNamed(AppRoutesName.noInternetConnectionView);
      return;
    }

    // Network is connected, check app flow
    await _navigateBasedOnAppState();
  }

  Future<void> _navigateBasedOnAppState() async {
    // Check if first time launch
    final isFirstTime = await SharedPreferencesHelper.isFirstTime();

    if (isFirstTime) {
      // First time - Show onboarding
      AppNavigators.pushReplacementNamed(AppRoutesName.onBoardView);
      return;
    }

    // Not first time - Check authentication
    final authToken = await SharedPreferencesHelper.getUserToken();

    if (authToken != null && authToken.isNotEmpty) {
      // User is logged in - Go to dashboard
      AppNavigators.pushReplacementNamed(AppRoutesName.dashboardView);
    } else {
      // User is not logged in - Go to login
      AppNavigators.pushReplacementNamed(AppRoutesName.loginView);
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
              height: MediaQuery.of(context).size.width * .2,
              width: MediaQuery.of(context).size.width * .2,
            ),
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
