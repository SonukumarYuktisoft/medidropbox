import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalEmergencySection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalEmergencySection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.emergencyAvailable != true) {
      return const SizedBox.shrink();
    }

    return _sectionCard(
      icon: Icons.emergency,
      title: "Emergency Services",
      subtitle: "Available 24x7",
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