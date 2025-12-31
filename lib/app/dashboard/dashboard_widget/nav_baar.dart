import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/profile/bloc/profile_bloc.dart';

class NavBaar extends StatelessWidget {
  const NavBaar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listenWhen: (p, c) => p.tabPosition != c.tabPosition,
      listener: (context, state) {
        if (state.tabPosition == 3) {
          context.read<AppointmentBloc>().add(OnGetBooking());
        }
        if (state.tabPosition == 4) {
          context.read<ProfileBloc>().add(OnGetProfile());
        }
      },
      child: BlocBuilder<DashboardBloc, DashboardState>(
        buildWhen: (p, c) => p.tabPosition != c.tabPosition,
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.tabPosition,
            onTap: (index) =>
                context.read<DashboardBloc>().add(OnChangedTapPosition(index)),
            type: BottomNavigationBarType.fixed,
            items: const [
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
          );
        },
      ),
    );
  }
}
