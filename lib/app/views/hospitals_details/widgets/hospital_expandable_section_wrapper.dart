import 'package:medidropbox/app/views/hospitals_details/bloc/hospital_detail_bloc.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_about_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_contact_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_country_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_emergency_section.dart';import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_facilities_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_location_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_services_section.dart' show HospitalServicesSection;
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_social_media_section.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/hospital_shimmer/hospital_%20detail_shimmer/hospital_expandable_details_section_shimmer.dart';

class HospitalExpandableSectionWrapper extends StatelessWidget {
  const HospitalExpandableSectionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalDetailBloc, HospitalDetailState>(
      buildWhen: (previous, current) => previous.hospitalDetailStatus!=current.hospitalDetailStatus,
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
                  /// FACILITIES
              HospitalFacilitiesSection(hospital: hospital),
              if (hospital.facilities?.isNotEmpty == true) 24.heightBox,

              /// SERVICES
              HospitalServicesSection(hospital: hospital),
              if (hospital.services?.isNotEmpty == true) 24.heightBox,

              /// EMERGENCY
              HospitalEmergencySection(hospital: hospital),
              if (hospital.emergencyAvailable == true) 24.heightBox,

              /// CONTACT INFO
              HospitalContactSection(hospital: hospital),
              if (hospital.emergencyCallNumber != null ||
                  hospital.bookingCallNumber != null)
                24.heightBox,

              /// ABOUT
              HospitalAboutSection(hospital: hospital),
              if (hospital.foundedOn != null || hospital.founder != null)
                24.heightBox,

              /// LOCATION
              HospitalLocationSection(hospital: hospital),
              if (hospital.address != null) 24.heightBox,

              /// SOCIAL MEDIA
              HospitalSocialMediaSection(hospital: hospital),
              if (hospital.socialMediaLinks?.isNotEmpty == true) 24.heightBox,

              /// COUNTRY
              HospitalCountrySection(hospital: hospital),
              if (hospital.country != null && hospital.country!.isNotEmpty)
                24.heightBox,
              
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}