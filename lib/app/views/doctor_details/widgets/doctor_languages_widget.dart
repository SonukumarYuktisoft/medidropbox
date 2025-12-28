import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorLanguagesWidget extends StatelessWidget {
  final List<String>? languages;

  const DoctorLanguagesWidget({
    super.key,
    this.languages,
  });

  @override
  Widget build(BuildContext context) {
    if (languages?.isEmpty ?? true) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Languages'.toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        8.heightBox,
        languages!.join(', ').toHeadingText(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
        24.heightBox,
      ],
    );
  }
}