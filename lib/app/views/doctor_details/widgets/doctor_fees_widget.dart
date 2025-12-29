import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorFeesWidget extends StatelessWidget {
  final double? fees;
  final bool? allowRemote;

  const DoctorFeesWidget({
    super.key,
    this.fees,
    this.allowRemote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (fees != null) ...[
          _buildSectionCard(
            icon: Icons.currency_rupee,
            title: 'Consultation Fee',
            subtitle: '₹${fees!.toStringAsFixed(0)}',
          ),
          12.heightBox,
        ],
        if (allowRemote == true) ...[
          _buildSectionCard(
            icon: Icons.videocam,
            title: 'Remote Consultation',
            subtitle: 'Available',
          ),
          24.heightBox,
        ],
      ],
    );
  }

  Widget _buildSectionCard({
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