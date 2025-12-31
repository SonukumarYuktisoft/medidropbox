import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalFacilitiesSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalFacilitiesSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.facilities?.isNotEmpty != true) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentGeometry.centerLeft,
          child: "Facilities".toHeadingText(
            appFontStyle: AppFontStyle.semiBold,
          ),
        ),
        10.heightBox,
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: hospital.facilities!
              .where((facility) =>  facility.isNotEmpty)
              .map((facility) {
                return _FacilityChip(
                  _getFacilityIcon(facility),
                  facility,
                );
              })
              .toList(),
        ),
      ],
    );
  }

  IconData _getFacilityIcon(String facility) {
    if (facility.isEmpty) return Icons.check_circle;

    final lowerFacility = facility.toLowerCase();
    if (lowerFacility.contains('lab')) return Icons.biotech;
    if (lowerFacility.contains('icu')) return Icons.local_hospital;
    if (lowerFacility.contains('parking')) return Icons.local_parking;
    if (lowerFacility.contains('ambulance')) return Icons.car_crash;
    if (lowerFacility.contains('cafeteria') || lowerFacility.contains('cafe')) {
      return Icons.local_cafe;
    }
    if (lowerFacility.contains('pharmacy')) return Icons.medication;
    if (lowerFacility.contains('xray') || lowerFacility.contains('x-ray')) {
      return Icons.camera_alt;
    }
    if (lowerFacility.contains('emergency')) return Icons.emergency;
    if (lowerFacility.contains('bed')) return Icons.bed;
    if (lowerFacility.contains('wifi')) return Icons.wifi;
    if (lowerFacility.contains('wheelchair')) return Icons.accessible;

    return Icons.check_circle;
  }
}

class _FacilityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FacilityChip(this.icon, this.label);

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