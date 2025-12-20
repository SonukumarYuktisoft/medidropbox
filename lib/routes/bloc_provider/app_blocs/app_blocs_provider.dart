// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/core/navigators/NavigationState.dart';
import 'package:medidropbox/core/utility/utility_screen/network/bloc/network_bloc.dart';
import 'package:medidropbox/view/features/OnboardingScreen/bloc/onboarding_bloc.dart';
import 'package:medidropbox/view/features/auth/bloc/auth_bloc.dart';
import 'package:provider/single_child_widget.dart';

class AppBlocsProvider {
  static List<SingleChildWidget> appBloc = [
    BlocProvider(create: (context) => NetworkBloc()..add(NetworkObserve())),
    BlocProvider(create: (context) => NavigationCubit()),
    BlocProvider(create: (context) => AuthBloc()),

    BlocProvider(create: (context) => OnboardingBloc()),
  ];
}
