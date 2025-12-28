import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalLocationSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalLocationSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.address == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Location".toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        10.heightBox,
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: (hospital.address!.locationUrl != null &&
                      hospital.address!.locationUrl!.isNotEmpty
                  ? hospital.address!.locationUrl!
                  : AppNetworkImages.mapPreview)
              .toImage(
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
        ),
      ],
    );
  }
}