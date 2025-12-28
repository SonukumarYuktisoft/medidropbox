import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorStatsWidget extends StatelessWidget {
  final double? rating;
  final int? servedPatientCount;
  final int? averageConsultationTime;

  const DoctorStatsWidget({
    super.key,
    this.rating,
    this.servedPatientCount,
    this.averageConsultationTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _InfoTile(
          icon: Icons.star,
          title: 'Rating',
          value: rating?.toStringAsFixed(1) ?? '0.0',
        ),
        _InfoTile(
          icon: Icons.people,
          title: 'Patients',
          value: '${servedPatientCount ?? 0}+',
        ),
        _InfoTile(
          icon: Icons.timer,
          title: 'Avg Time',
          value: '${averageConsultationTime ?? 0}m',
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