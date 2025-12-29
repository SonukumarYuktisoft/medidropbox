import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorExpertiseWidget extends StatelessWidget {
  final List<String>? expertise;

  const DoctorExpertiseWidget({
    super.key,
    this.expertise,
  });

  @override
  Widget build(BuildContext context) {
    if (expertise?.isEmpty ?? true) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Expertise'.toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        10.heightBox,
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: expertise!.map((exp) {
            return _FacilityChip(Icons.verified, exp);
          }).toList(),
        ),
        24.heightBox,
      ],
    );
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