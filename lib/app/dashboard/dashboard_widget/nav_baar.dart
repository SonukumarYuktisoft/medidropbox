import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
class NavBaar extends StatelessWidget {
  const NavBaar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.tabPosition!=current.tabPosition,
      builder: (context, state) {
        var currentIndex = state.tabPosition;
        return Container(
           decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
             currentIndex: state.tabPosition,
            onTap:(p)=>context.read<DashboardBloc>().add(OnChangedTapPosition(p)),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
              
                label: "Home",
              ),
              BottomNavigationBarItem(
                 icon: Icon(Icons.medical_services_outlined),
                label: "Dr.",
              ),

               BottomNavigationBarItem(
                  icon: Icon(Icons.local_hospital_outlined),
              
                label: "hospital",
              ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.calendar_month_outlined),
                label: "Booking",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
              
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
