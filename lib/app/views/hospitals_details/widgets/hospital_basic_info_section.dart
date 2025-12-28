import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalBasicInfoSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalBasicInfoSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// CATEGORY + RATING
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _chip("Hospital"),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                4.widthBox,
                "4.5".toHeadingText(
                  appFontStyle: AppFontStyle.semiBold,
                ),
                4.widthBox,
                "(${hospital.services?.length ?? 0} Services)".toHeadingText(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ],
            ),
          ],
        ),

        12.heightBox,

        /// NAME
        (hospital.name ?? "Hospital Name").toHeadingText(
          fontSize: 20,
          appFontStyle: AppFontStyle.bold,
        ),

        8.heightBox,

        /// LOCATION
        Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 16,
              color: Colors.grey,
            ),
            6.widthBox,
            Expanded(
              child: _getFullAddress(hospital).toHeadingText(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _chip(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.withOpacity(0.1),
        foregroundColor: Colors.blue,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      child: text.toHeadingText(
        color: Colors.blue,
        fontSize: 12,
        appFontStyle: AppFontStyle.semiBold,
      ),
      onPressed: null,
    );
  }

  String _getFullAddress(HospitalDetailModel hospital) {
    if (hospital.address == null) return "Address not available";

    final parts = <String>[];

    if (hospital.address!.addressLine1?.isNotEmpty == true) {
      parts.add(hospital.address!.addressLine1!);
    }
    if (hospital.address!.addressLine2?.isNotEmpty == true) {
      parts.add(hospital.address!.addressLine2!);
    }
    if (hospital.address!.city?.isNotEmpty == true) {
      parts.add(hospital.address!.city!);
    }
    if (hospital.address!.state?.isNotEmpty == true) {
      parts.add(hospital.address!.state!);
    }
    if (hospital.address!.country?.isNotEmpty == true) {
      parts.add(hospital.address!.country!);
    }
    if (hospital.address!.pincode?.isNotEmpty == true) {
      parts.add(hospital.address!.pincode!);
    }

    return parts.isEmpty ? "Address not available" : parts.join(", ");
  }
}