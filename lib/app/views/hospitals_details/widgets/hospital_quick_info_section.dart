import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalQuickInfoSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalQuickInfoSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _InfoTile(
          icon: Icons.local_hospital,
          title: "Services",
          value: "${hospital.services?.length ?? 0}+",
        ),
        _InfoTile(
          icon: Icons.medical_services,
          title: "Facilities",
          value: "${hospital.facilities?.length ?? 0}+",
        ),
        _InfoTile(
          icon: Icons.schedule,
          title: "Emergency",
          value: hospital.emergencyAvailable == true ? "24x7" : "No",
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: Icon(icon, color: Colors.blue),
        ),
        6.heightBox,
        value.toHeadingText(appFontStyle: AppFontStyle.semiBold),
        title.toHeadingText(color: Colors.grey, fontSize: 12),
      ],
    );
  }
}