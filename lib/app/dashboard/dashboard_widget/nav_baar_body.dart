import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/dashboard_widget/dashboard_top_baar.dart';
import 'package:medidropbox/app/dashboard/dashboard_widget/hospitals_dropDown.dart';
import 'package:medidropbox/app/dashboard/tabs/doctor/doctor_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/home/home_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/appointment_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/profile/profile_tab.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class NavBaarBody extends StatelessWidget {
  const NavBaarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) =>
          previous.tabPosition != current.tabPosition,
      builder: (context, state) {
        return Column(
          children: [
            DashboardTopBaar(),

            10.heightBox,
            Expanded(
              child: [
                HomeTab(),
                DoctorTab(),
                AppointmentTab(),
                ProfileTab(),
              ][state.tabPosition],
            ),
          ],
        );
      },
    );
  }
}
