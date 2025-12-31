
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/models/common_model/book_appointment_model.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_booking_dialog.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_contact_widget.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_expertise_widget.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_fees_widget.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_hospital_widget.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_languages_widget.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_profile_header.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_services_widget.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_specialty_widget.dart';
import 'package:medidropbox/app/views/doctor_details/widgets/doctor_stats_widget.dart';
import 'package:medidropbox/core/common/animated_book_button.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/doctor_shimmer/doctor_detail_shimmer/doctor_detail_shimmer.dart';
import 'package:medidropbox/core/helpers/data_not_found.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class DoctorDetailsView extends StatefulWidget {
  final String doctorId;

  const DoctorDetailsView({super.key, required this.doctorId});

  @override
  State<DoctorDetailsView> createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(OnGetDoctorById(widget.doctorId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // Loading state
        if (state.doctorDetailStatus == ApiStatus.loading) {
          return const DoctorDetailShimmer();
        }

        // Error state
        if (state.doctorDetailStatus == ApiStatus.error) {
          return Scaffold(
            backgroundColor: const Color(0xffF4F6FA),
            body: RefreshView(
              onPressed: () => context.read<HomeBloc>().add(
                OnGetDoctorById(widget.doctorId),
              ),
            ),
          );
        }

        // No data state
        if (state.doctorDetailStatus == ApiStatus.success &&
            state.doctorDetail == null) {
          return const Scaffold(
            backgroundColor: Color(0xffF4F6FA),
            body: DataNotFound(
              title: "No doctor data available",
              icon: Icons.person_off,
              iconColor: Colors.grey,
              iconSize: 64,
            ),
          );
        }

        final doctor = state.doctorDetail;
        if (doctor == null) {
          return Scaffold(
            backgroundColor: const Color(0xffF4F6FA),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  16.heightBox,
                  "No doctor data available".toHeadingText(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  24.heightBox,
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(
                        OnGetDoctorById(widget.doctorId),
                      );
                    },
                    child: "Retry".toHeadingText(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }

        // Success state with data
        return Scaffold(
          bottomNavigationBar: "Book Appointment".toHeadingText(
            color: Colors.white
          ).asElevatedButton(
            onPressed: (){
               AppNavigators.pushNamed(AppRoutesName.paymentMethodView,
             extra: BookAppointmentModel(docId: doctor.id.toString(),
             hosId: doctor.hospitalId.toString(),
             docFees:doctor.fees.toString()).toJson());


            }).paddingAll(15),
          backgroundColor: const Color(0xffF4F6FA),
          floatingActionButton: doctor.fees != null
              ? AnimatedBookButton(
                  onPressed: () {
                    DoctorBookingDialog.show(context, doctor);
                  },
                
                  fees: '₹${doctor.fees}',
                )
              : null,
          body: CustomScrollView(
            slivers: [
              // Profile Header
              DoctorProfileHeader(
                profilePhotoUrl: doctor.profilePhotoUrl,
                name: doctor.name ?? 'Unknown Doctor',
                title: doctor.title ?? 'Doctor',
                rating: doctor.rating,
                servedPatientCount: doctor.servedPatientCount,
              ),

              // Doctor Details Content
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Info (Name, Title, Rating)
                        DoctorBasicInfo(
                          name: doctor.name ?? 'Unknown Doctor',
                          title: doctor.title ?? 'Doctor',
                          rating: doctor.rating,
                          servedPatientCount: doctor.servedPatientCount ?? 0,
                        ),

                        20.heightBox,

                        // Stats (Rating, Patients, Avg Time)
                        DoctorStatsWidget(
                          rating: doctor.rating,
                          servedPatientCount: doctor.servedPatientCount,
                          averageConsultationTime:
                              doctor.averageConsultationTime,
                        ),

                        24.heightBox,

                        // Specialty & About
                        DoctorSpecialtyWidget(
                          specialty: doctor.specialty,
                          about: doctor.about,
                        ),

                        // Expertise
                        DoctorExpertiseWidget(expertise: doctor.expertise),

                        // Services
                        DoctorServicesWidget(services: doctor.services),

                        // Languages
                        DoctorLanguagesWidget(languages: doctor.language),

                        // Fees & Remote
                        DoctorFeesWidget(
                          fees: doctor.fees,
                          allowRemote: doctor.allowRemote,
                        ),

                        // Contact Info
                        DoctorContactWidget(
                          phone: doctor.phone,
                          email: doctor.email,
                        ),

                        // Hospital
                        DoctorHospitalWidget(
                          hospitalName: doctor.hospitalName,
                          address: doctor.address,
                        ),

                        80.heightBox, // Space for floating button
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
