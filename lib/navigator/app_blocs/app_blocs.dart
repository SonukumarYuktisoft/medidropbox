// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/views/hospitals_details/bloc/hospital_bloc.dart';
import 'package:medidropbox/core/utility/utility_screen/network/bloc/network_bloc.dart';
import 'package:medidropbox/app/views/OnboardingScreen/bloc/onboarding_bloc.dart';
import 'package:medidropbox/app/auth/bloc/auth_bloc.dart';
import 'package:medidropbox/navigator/injector/repo_injectors.dart';
import 'package:provider/single_child_widget.dart';

class AppBlocs {
  static List<SingleChildWidget> appBloc = [
    BlocProvider(create: (context) => NetworkBloc()..add(NetworkObserve())),
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => OnboardingBloc()),
    BlocProvider(create: (_) => DashboardBloc()),
    BlocProvider(create: (_) => HomeBloc(RepoInjectors.loginRepo, RepoInjectors.doctorRepo)),
     BlocProvider(create: (context) => HospitalBloc(),)
  
  ];
}
