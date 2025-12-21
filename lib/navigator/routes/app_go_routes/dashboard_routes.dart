import 'package:go_router/go_router.dart';
import 'package:medidropbox/app/dashboard/dashboard_view.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';


class DashboardRoutes {
 static List<RouteBase> route =[
   GoRoute(
        path: AppRoutesPath.dashboard,
        name: AppRoutesName.dashboardView,
        builder: (context, state) => const DashboardView(),
      ),
   
  ];
}