import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:shimmer/shimmer.dart';

class HospitalTopSectionDetailsShimmer extends StatelessWidget {
  const HospitalTopSectionDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER IMAGE SHIMMER
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.7,
            color: Colors.grey[300],
          ),
        ),

        /// CONTENT SHIMMER
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// CATEGORY + RATING SHIMMER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 120,
                      height: 20,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),

              12.heightBox,

              /// HOSPITAL NAME SHIMMER
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 28,
                  color: Colors.grey[300],
                ),
              ),

              8.heightBox,

              /// ADDRESS SHIMMER
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 16,
                  color: Colors.grey[300],
                ),
              ),

              20.heightBox,

              /// QUICK INFO TILES SHIMMER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      6.heightBox,
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 40,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                      4.heightBox,
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 60,
                          height: 12,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  );
                }),
              ),

              24.heightBox,
            ],
          ),
        ),
      ],
    );
  }
}