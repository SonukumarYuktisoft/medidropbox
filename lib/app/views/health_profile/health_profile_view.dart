import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/app/views/health_profile/health_widget/bmi_report_tab.dart';
import 'package:medidropbox/app/views/health_profile/health_widget/health_record_tab.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HealthProfileView extends StatefulWidget {
  const HealthProfileView({super.key});

  @override
  State<HealthProfileView> createState() => _HealthProfileViewState();
}

class _HealthProfileViewState extends State<HealthProfileView> {
  @override
  void initState() {
    context.read<HealthProfileBloc>().add((OnBMIReportApi()));
    context.read<HealthProfileBloc>().add((OnGetLatestVitalApi()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
           isShowBorder: false,
          title: "Health Profile",leadColor: Colors.white,titleColor: Colors.white,
           bottom:_tabs(),
          ),
        body: TabBarView(
        children: [
        BmiReportTab(),
        HealthRecordTab(),
        ]),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Vital',
           child: Icon(Icons.add,shadows: toIconShadow()),
          onPressed: (){}),
      ),
    );
  }
  PreferredSizeWidget _tabs()=>TabBar(
    dividerHeight: 0,
    padding: EdgeInsets.symmetric(vertical: 10),
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorPadding: EdgeInsetsGeometry.all(8),
    indicator: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
   tabs: ["BMI Report","Health Record"].map((e)=>Tab(
    text: e,
   )).toList(),
  );
}

