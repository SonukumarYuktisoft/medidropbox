import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalCountrySection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalCountrySection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.country == null || hospital.country!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _sectionCard(
      icon: Icons.public,
      title: "Country",
      subtitle: hospital.country!,
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