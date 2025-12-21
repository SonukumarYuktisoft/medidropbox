import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/batches/batches_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/home/home_tab.dart';
import 'package:medidropbox/app/dashboard/tabs/store/store_tab.dart';
import 'package:medidropbox/core/helpers/app_export.dart';


class NavBaarBody extends StatelessWidget {
  const NavBaarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.tabPosition!=current.tabPosition,
      builder: (context, state) {
        return [HomeTab(),BatchesTab(),StoreTab()][state.tabPosition];
      },
    );
  }
}
