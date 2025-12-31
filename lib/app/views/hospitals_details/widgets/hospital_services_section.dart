import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalServicesSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalServicesSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.services?.isNotEmpty != true) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentGeometry.centerLeft,
          child: "Services".toHeadingText(
            appFontStyle: AppFontStyle.semiBold,
          ),
        ),
        10.heightBox,
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: hospital.services!
              .where((service) =>  service.isNotEmpty)
              .map((service) {
                return _ServiceChip(
                  Icons.medical_services,
                  service,
                );
              })
              .toList(),
        ),
      ],
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServiceChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          6.widthBox,
          label.toHeadingText(fontSize: 12),
        ],
      ),
    );
  }
}