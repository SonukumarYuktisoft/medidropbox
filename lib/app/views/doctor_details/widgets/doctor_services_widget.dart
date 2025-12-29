import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorServicesWidget extends StatelessWidget {
  final List<String>? services;

  const DoctorServicesWidget({
    super.key,
    this.services,
  });

  @override
  Widget build(BuildContext context) {
    if (services?.isEmpty ?? true) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Services'.toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        10.heightBox,
        ...services!.map((service) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 20,
                ),
                8.widthBox,
                Expanded(
                  child: service.toHeadingText(fontSize: 14),
                ),
              ],
            ),
          );
        }),
        24.heightBox,
      ],
    );
  }
}