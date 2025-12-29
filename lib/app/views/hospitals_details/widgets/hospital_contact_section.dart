import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalContactSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalContactSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.emergencyCallNumber == null &&
        hospital.bookingCallNumber == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Contact Information".toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        12.heightBox,
        if (hospital.emergencyCallNumber != null)
          _sectionCard(
            icon: Icons.phone,
            title: "Emergency",
            subtitle: hospital.emergencyCallNumber.toString(),
          ),
        if (hospital.bookingCallNumber != null) ...[
          12.heightBox,
          _sectionCard(
            icon: Icons.call,
            title: "Booking",
            subtitle: hospital.bookingCallNumber.toString(),
          ),
        ],
      ],
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          10.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.toHeadingText(appFontStyle: AppFontStyle.semiBold),
                subtitle.toHeadingText(color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}