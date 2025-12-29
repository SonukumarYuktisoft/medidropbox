import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorContactWidget extends StatelessWidget {
  final dynamic phone;
  final dynamic email;

  const DoctorContactWidget({
    super.key,
    this.phone,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhone = phone != null && phone.toString().isNotEmpty;
    final hasEmail = email != null && email.toString().isNotEmpty;

    if (!hasPhone && !hasEmail) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Contact Information'.toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        12.heightBox,
        if (hasPhone)
          _buildSectionCard(
            icon: Icons.phone,
            title: 'Phone',
            subtitle: phone.toString(),
          ),
        if (hasEmail) ...[
          12.heightBox,
          _buildSectionCard(
            icon: Icons.email,
            title: 'Email',
            subtitle: email.toString(),
          ),
        ],
        24.heightBox,
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