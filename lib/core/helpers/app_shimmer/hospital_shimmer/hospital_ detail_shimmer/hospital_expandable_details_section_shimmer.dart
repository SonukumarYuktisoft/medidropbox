import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:shimmer/shimmer.dart';

class HospitalExpandableDetailsSectionShimmer extends StatelessWidget {
  const HospitalExpandableDetailsSectionShimmer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SHOW MORE BUTTON SHIMMER
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),

          12.heightBox,

          /// FACILITIES SECTION SHIMMER
          _buildSectionShimmer(context, "Facilities"),

          24.heightBox,

          /// SERVICES SECTION SHIMMER
          _buildSectionShimmer(context, "Services"),

          24.heightBox,

          /// CONTACT INFO SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 20,
              color: Colors.grey[300],
            ),
          ),

          12.heightBox,

          _buildCardShimmer(),

          12.heightBox,

          _buildCardShimmer(),

          24.heightBox,

          /// LOCATION SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 20,
              color: Colors.grey[300],
            ),
          ),

          10.heightBox,

          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          40.heightBox,
        ],
      ),
    );
  }

  Widget _buildSectionShimmer(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Title
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 120,
            height: 20,
            color: Colors.grey[300],
          ),
        ),

        10.heightBox,

        /// Chips Shimmer
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(6, (index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 80 + (index * 10.0),
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}