import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/app/views/hospitals_details/bloc/hospital_bloc.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_about_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_contact_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_country_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_emergency_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_facilities_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_location_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_services_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_social_media_section.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalExpandableDetailsSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalExpandableDetailsSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalBloc, HospitalState>(

      builder: (context, state) {


        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: Icon(
                    state.showMoreDetails
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                  label: Text(
                    state.showMoreDetails ? "Show Less" : "Show More",
                  ),
                  onPressed: () {
                    context.read<HospitalBloc>().add(
                          ToggleHospitalDetails(),
                        );
                  },
                ),
              ],
            ),

            if (state.showMoreDetails) ...[
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
          ],
        );
      },
    );
  }
}