import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorSpecialtyWidget extends StatelessWidget {
  final String? specialty;
  final String? about;

  const DoctorSpecialtyWidget({
    super.key,
    this.specialty,
    this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (specialty != null && specialty!.isNotEmpty) ...[
          'Specialty'.toHeadingText(
            appFontStyle: AppFontStyle.semiBold,
          ),
          8.heightBox,
          Chip(
            label: Text(specialty!),
            backgroundColor: Colors.blue.shade50,
            labelStyle: TextStyle(color: Colors.blue.shade700),
          ),
          24.heightBox,
        ],
        if (about != null && about!.isNotEmpty) ...[
          'About'.toHeadingText(
            appFontStyle: AppFontStyle.semiBold,
          ),
          8.heightBox,
          about!.toHeadingText(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
          24.heightBox,
        ],
      ],
    );
  }
}