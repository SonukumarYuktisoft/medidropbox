import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_expandable_details_section.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/hospital_shimmer/hospital_%20detail_shimmer/hospital_expandable_details_section_shimmer.dart';

class HospitalExpandableSectionWrapper extends StatelessWidget {
  const HospitalExpandableSectionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.hospitalDetailStatus == ApiStatus.loading) {
          return HospitalExpandableDetailsSectionShimmer();
        } else if (state.hospitalDetailStatus == ApiStatus.error) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  12.heightBox,
                  "Failed to load details".toHeadingText(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          );
        } else if (state.hospitalDetailStatus == ApiStatus.success &&
            state.hospitalDetail != null) {
          final hospital = state.hospitalDetail!;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: Column(
              children: [
                HospitalExpandableDetailsSection(hospital: hospital),
                40.heightBox,
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}