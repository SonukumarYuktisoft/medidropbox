import 'package:medidropbox/app/dashboard/dashboard_widget/nav_baar.dart';
import 'package:medidropbox/app/dashboard/dashboard_widget/nav_baar_body.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: NavBaarBody(),
      bottomNavigationBar: NavBaar(),
    );
  }
}