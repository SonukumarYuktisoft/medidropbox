import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_basic_info_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_header_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_quick_info_section.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/hospital_shimmer/hospital_%20detail_shimmer/hospital_top_section_details_shimmer.dart';

class HospitalTopSection extends StatelessWidget {
  const HospitalTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.hospitalDetailStatus == ApiStatus.loading) {
          return HospitalTopSectionDetailsShimmer();
        } else if (state.hospitalDetailStatus == ApiStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                12.heightBox,
                "Failed to load hospital details".toHeadingText(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ],
            ),
          );
        } else if (state.hospitalDetailStatus == ApiStatus.success &&
            state.hospitalDetail != null) {
          final hospital = state.hospitalDetail!;

          return Column(
            children: [
              /// HEADER IMAGE
              HospitalHeaderSection(hospital: hospital),

              /// CONTENT
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// BASIC INFO
                    HospitalBasicInfoSection(hospital: hospital),

                    20.heightBox,

                    /// QUICK INFO
                    HospitalQuickInfoSection(hospital: hospital),

                    24.heightBox,
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}