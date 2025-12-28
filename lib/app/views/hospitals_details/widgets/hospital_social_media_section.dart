import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/extensions/url_launcher_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalSocialMediaSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalSocialMediaSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    if (hospital.socialMediaLinks?.isNotEmpty != true) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        "Connect With Us".toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        12.heightBox,
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,




















































          spacing: 10,
          runSpacing: 10,
          children: hospital.socialMediaLinks!
              .where(
                (social) =>
                    social.platformName != null &&
                    social.platformName!.isNotEmpty,
              )
              .map((social) {
                return _chip(
                  social.platformName ?? "Social",
                  url: social.profileUrl ?? "",
                );
              })
              .toList(),
        ),
      ],
    );
  }

  Widget _chip(String text, {String? url}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.withOpacity(0.1),
        foregroundColor: Colors.blue,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      child: text.toHeadingText(
        color: Colors.blue,
        fontSize: 12,
        appFontStyle: AppFontStyle.semiBold,
      ),
      onPressed: () {
        if (url == null || url.isEmpty) return;
        url.openUrl();
      },
    );
  }
}