import 'package:medidropbox/app/dashboard/tabs/doctor_tab/widgets/doctor_profile_card.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/hospital_shimmer/hospital_%20detail_shimmer/hospital_doctors_detail_section_shimmer.dart';

class HospitalDoctorsSection extends StatelessWidget {
  const HospitalDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.allDoctorStatus == ApiStatus.loading) {
          return HospitalDoctorsDetailSectionShimmer();
        } else if (state.allDoctorStatus == ApiStatus.error) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.grey),
                  8.heightBox,
                  const Text('Error loading doctors'),
                ],
              ),
            ),
          );
        } else if (state.allDoctorStatus == ApiStatus.success &&
            state.allDoctorList != null &&
            state.allDoctorList!.isNotEmpty) {
          final doctors = state.allDoctorList!;

          return Container(
            color: Colors.white, // Background color for the section
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Our Doctors".toHeadingText(
                  fontSize: 18,
                  appFontStyle: AppFontStyle.semiBold,
                ),
                12.heightBox,
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return DoctorProfileCard(doctor: doctor);
                    },
                    separatorBuilder: (context, index) => 12.widthBox,
                    itemCount: doctors.length,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}