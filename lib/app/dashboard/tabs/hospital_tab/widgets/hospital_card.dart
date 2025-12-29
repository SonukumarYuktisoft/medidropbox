import 'package:medidropbox/app/models/hospitals_models/all_hospital_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalTabCard extends StatelessWidget {
  final AllHospitalModel hospital;

  const HospitalTabCard({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigators.pushNamed(
          AppRoutesName.hospitalDetailsView,
          extra: hospital.id.toString(),
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
            /// Hospital Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: (hospital.images?.isNotEmpty == true
                        ? hospital.images!.first
                        : AppNetworkImages.hospital)
                    .toImage(
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
              ),
            ),

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
                      /// Hospital Name
                      Text(
                        hospital.name ?? "Hospital",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),

                      /// Location
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              hospital.address?.city ?? "Location",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// Rating / Emergency Badge
                      if (hospital.emergencyAvailable == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.emergency,
                                size: 11,
                                color: Colors.green.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "24x7",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  /// Bottom info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Services", style: _labelStyle()),
                      Text(
                        "${hospital.services?.length ?? 0}+",
                        style: _valueStyle(),
                      ),
                      const SizedBox(height: 4),
                      Text("Facilities", style: _labelStyle()),
                      Text(
                        "${hospital.facilities?.length ?? 0}+",
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