import 'package:medidropbox/app/models/doctors_models/all_doctors_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorCard extends StatelessWidget {
  final AllDoctorsModel doctor;

  const DoctorCard({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigators.pushNamed(
          AppRoutesName.doctorDetailsView,
          // pathParameters: {'id': '${doctor.id}'},
          extra: doctor.id.toString(),

        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Center(child: doctor.profilePhotoUrl.toCircularImage(size: 70)),
      
            const SizedBox(height: 10),
      
            /// Flexible content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          ...List.generate(
                            doctor.rating.floor(),
                            (index) => const Icon(
                              Icons.star,
                              size: 13,
                              color: Colors.amber,
                            ),
                          ),
                          if (doctor.rating % 1 != 0)
                            const Icon(
                              Icons.star_half,
                              size: 13,
                              color: Colors.amber,
                            ),
                          const SizedBox(width: 4),
                          Text(
                            doctor.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
      
                  /// Bottom info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Patients Served", style: _labelStyle()),
                      Text("${doctor.servedPatientCount}+", style: _valueStyle()),
                      const SizedBox(height: 4),
                      Text("Fees", style: _labelStyle()),
                      Text(
                        "₹${doctor.fees.toStringAsFixed(0)}",
                        style: _valueStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _labelStyle() => const TextStyle(fontSize: 11, color: Colors.grey);

  TextStyle _valueStyle() =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
}
