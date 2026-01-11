import 'package:medidropbox/app/dashboard/tabs/reports/dialog/create_vital_dialog.dart';
import 'package:medidropbox/app/dashboard/tabs/reports/report_tabs/health_report/health_report_main_view.dart';
import 'package:medidropbox/app/dashboard/tabs/reports/report_tabs/lab_reports_tab.dart';
import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';

import '../../../../core/helpers/app_export.dart';

class ReportsTabView extends StatefulWidget {
  const ReportsTabView({super.key});

  @override
  State<ReportsTabView> createState() => _ReportsTabViewState();
}

class _ReportsTabViewState extends State<ReportsTabView> {
@override
  void initState() {
    context.read<HealthProfileBloc>().add(OnGetHealthProfile());
    context.read<HealthProfileBloc>().add(OnBMIReportApi());
    context.read<HealthProfileBloc>().add(OnGetLatestVitalApi());
    context.read<HealthProfileBloc>().add(OnGetVitalHistoryApi());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _tabs(),
              Expanded(
                child: TabBarView(
                children: [
                HealthReportMainView(),
                LabReportsTab(),
                ]),
              ),
            ],
          ),
        ),
       
      ),
    );
  }
  PreferredSizeWidget _tabs()=>TabBar(
    dividerHeight: 0,
    padding: EdgeInsets.symmetric(vertical: 10),
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorPadding: EdgeInsetsGeometry.all(8),
    
    labelStyle: TextStyle( color: Colors.white,fontWeight: FontWeight.w500),
    indicator: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10)
    ),
   tabs: ["Health Reports","Lab Reports"].map((e)=>Tab(
    text: e,
   )).toList(),
  );
}