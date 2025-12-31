// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/doctor_tab/bloc/doctor_tab_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/profile/bloc/profile_bloc.dart';

import 'package:medidropbox/app/views/hospitals_details/bloc/hospital_detail_bloc.dart';
import 'package:medidropbox/app/views/payment_method/bloc/peyment_method_bloc.dart' show PeymentMethodBloc;
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
    BlocProvider(create: (_) => ProfileBloc(RepoInjectors.profile)),
    BlocProvider(create: (_) => AppointmentBloc(RepoInjectors.appointmentRepo)),
    BlocProvider(create: (_) => HomeBloc(RepoInjectors.hospitalRepo, RepoInjectors.doctorRepo)),
    BlocProvider(create: (_) => DoctorTabBloc(RepoInjectors.doctorRepo)),
    BlocProvider(create: (context) => HospitalDetailBloc(RepoInjectors.hospitalRepo,
    RepoInjectors.doctorRepo)),
    BlocProvider(create: (context) => HospitalFilterBloc(RepoInjectors.hospitalRepo)),
    BlocProvider(create: (context) => PeymentMethodBloc(RepoInjectors.appointmentRepo))
  ];
}
