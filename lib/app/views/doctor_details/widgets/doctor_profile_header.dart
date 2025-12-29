import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorProfileHeader extends StatelessWidget {
  final String? profilePhotoUrl;
  final String name;
  final String title;
  final double? rating;
  final int? servedPatientCount;

  const DoctorProfileHeader({
    super.key,
    this.profilePhotoUrl,
    required this.name,
    required this.title,
    this.rating,
    this.servedPatientCount,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade700],
            ),
          ),
          child: Center(
            child: (profilePhotoUrl ?? '').toCircularImage(size: 120),
          ),
        ),
      ),
    );
  }
}

class DoctorBasicInfo extends StatelessWidget {
  final String name;
  final String title;
  final double? rating;
  final int? servedPatientCount;

  const DoctorBasicInfo({
    super.key,
    required this.name,
    required this.title,
    this.rating,
    this.servedPatientCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildChip("Doctor"),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                4.widthBox,
                (rating?.toStringAsFixed(1) ?? '0.0').toHeadingText(
                  appFontStyle: AppFontStyle.semiBold,
                ),
                4.widthBox,
                "($servedPatientCount Patients)".toHeadingText(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ],
            ),
          ],
        ),
        12.heightBox,
        name.toHeadingText(
          fontSize: 20,
          appFontStyle: AppFontStyle.bold,
        ),
        8.heightBox,
        title.toHeadingText(
          color: Colors.grey,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: text.toHeadingText(
        color: Colors.blue,
        fontSize: 12,
        appFontStyle: AppFontStyle.semiBold,
      ),
    );
  }
}