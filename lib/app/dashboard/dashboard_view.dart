import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/dashboard_widget/dashboard_top_baar.dart';
import 'package:medidropbox/app/dashboard/dashboard_widget/nav_baar.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/appointment_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/doctor_tab/doctor_tab.dart' show DoctorTab;
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/home/home_tab.dart' show HomeTab;
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/hospital_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/profile/profile_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/reports/reports_tab_view.dart';
import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/app/views/upload_lab_report/bloc/upload_lab_report_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    context.read<HomeBloc>().add(OnGetAllHospital());
    context.read<HomeBloc>().add(OnGetAllDoctors('1'));
    context.read<HomeBloc>().add(OnInitiateMyQueueApi());
    context.read<UploadLabReportBloc>().add(GetLabReportApi());
    context.read<HealthProfileBloc>().add(OnGetHealthProfile());
     context.read<HealthProfileBloc>().add((OnGetVitalHistoryApi()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(), bottomNavigationBar: NavBaar());
  }

 Widget _body()=>BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) =>
          previous.tabPosition != current.tabPosition,
      builder: (context, state) {
        return Column(
          children: [
            if(state.tabPosition==0)
            DashboardTopBaar(),
           10.heightBox,
            Expanded(child: [HomeTab(),ReportsTabView(), DoctorTab(),HospitalTab(),AppointmentTab(),ProfileTab(),][state.tabPosition])
          ],
        );
      },
    );

}
