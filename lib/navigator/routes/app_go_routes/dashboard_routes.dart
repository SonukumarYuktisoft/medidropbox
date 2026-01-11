import 'package:go_router/go_router.dart';
import 'package:medidropbox/app/dashboard/dashboard_view.dart';
import 'package:medidropbox/app/views/book_appointment/book_appointment_view.dart';
import 'package:medidropbox/app/views/doctor_details/doctor_details_view.dart';
import 'package:medidropbox/app/views/edit_profile/edit_profile.dart';
import 'package:medidropbox/app/views/health_profile/health_profile_view.dart';
import 'package:medidropbox/app/views/hospitals_details/hospital_details_view.dart';
import 'package:medidropbox/app/views/upload_lab_report/upload_lab_report_view.dart';
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
      builder: (context, state) {
        final hospitalId = state.extra as String;
        return HospitalDetailsView(hospitalId: hospitalId);
      },
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
        final doctorId = state.extra as String;
        return DoctorDetailsView(doctorId: doctorId);
      },
    ),

    
       GoRoute(
      path: AppRoutesPath.uploadLabReport,
      name: AppRoutesName.uploadLabReportView,
      builder: (context, state) =>UploadLabReportView(),
    ),

     GoRoute(
      path: AppRoutesPath.healthProfile,
      name: AppRoutesName.healthProfileView,
      builder: (context, state) =>HealthProfileView(),
    ),

  ];
}
