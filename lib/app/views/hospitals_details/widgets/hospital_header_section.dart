import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalHeaderSection extends StatelessWidget {
  final HospitalDetailModel hospital;

  const HospitalHeaderSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (hospital.images?.isNotEmpty == true
                ? hospital.images!.first
                : AppNetworkImages.hospital)
            .toImage(
              width: double.infinity,
              height: MediaQuery.heightOf(context) / 2.7,
              fit: BoxFit.cover,
            ),

        /// GRADIENT
        Container(
          height: MediaQuery.heightOf(context) / 2.7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.45),
                Colors.transparent,
              ],
            ),
          ),
        ),

        /// BACK BUTTON
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppBackBtn(),
        ),
      ],
    );
  }
}