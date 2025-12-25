import 'package:go_router/go_router.dart';
import 'package:medidropbox/app/dashboard/dashboard_view.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/booking_details.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/create_appointment.dart';
import 'package:medidropbox/app/views/book_appointment/book_appointment_view.dart';
import 'package:medidropbox/app/views/doctor_details/doctor_details.dart';
import 'package:medidropbox/app/views/edit_profile/edit_profile.dart';
import 'package:medidropbox/app/views/hospitals_details/hospital_details_view.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';

class DashboardRoutes {
  static List<RouteBase> route = [
    GoRoute(
      path: AppRoutesPath.dashboard,
      name: AppRoutesName.dashboardView,
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: AppRoutesPath.hospitalDetails,
      name: AppRoutesName.hospitalDetailsView,
      builder: (context, state) => const HospitalDetailsView(),
    ),
    GoRoute(
      path: AppRoutesPath.bookAppointment,
      name: AppRoutesName.bookAppointmentView,
      builder: (context, state) => const BookAppointmentView(),
    ),
    GoRoute(
      path: AppRoutesPath.editprofile,
      name: AppRoutesName.editprofileView,
      builder: (context, state) => const EditProfile(),
    ),
    GoRoute(
      path: AppRoutesPath.doctorDetails,
      name: AppRoutesName.doctorDetailsView,
      builder: (context, state) {
        var arg = state.extra as Map<String, dynamic>;
        return DoctorDetails(doctor: arg);
      },
    ),

    GoRoute(
      path: AppRoutesPath.createAppointment,
      name: AppRoutesName.createAppointmentView,
      builder: (context, state) {
        return CreateAppointmentPage();
      },
    ),
    GoRoute(
      path: AppRoutesPath.bookingDetails,
      name: AppRoutesName.bookingDetailsView,
      builder: (context, state) {
        var arg = state.extra as String;
        return BookingDetails(arg);
      },
    ),
  ];
}
