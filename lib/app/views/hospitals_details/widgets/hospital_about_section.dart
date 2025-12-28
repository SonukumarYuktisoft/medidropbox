import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalAboutSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalAboutSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.foundedOn == null && hospital.founder == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "About".toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        12.heightBox,
        if (hospital.foundedOn != null)
          _sectionCard(
            icon: Icons.calendar_today,
            title: "Founded On",
            subtitle:
                "${hospital.foundedOn!.day}/${hospital.foundedOn!.month}/${hospital.foundedOn!.year}",
          ),
        if (hospital.founder != null && hospital.founder.toString().isNotEmpty) ...[
          12.heightBox,
          _sectionCard(
            icon: Icons.person,
            title: "Founder",
            subtitle: hospital.founder.toString(),
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