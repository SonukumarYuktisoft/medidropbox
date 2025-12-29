import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:shimmer/shimmer.dart';

class HospitalDoctorsDetailSectionShimmer extends StatelessWidget {
  const HospitalDoctorsDetailSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SECTION TITLE SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              height: 22,
              color: Colors.grey[300],
            ),
          ),

          12.heightBox,

          /// DOCTORS LIST SHIMMER
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // Show 3 shimmer cards
              separatorBuilder: (context, index) => 12.widthBox,
              itemBuilder: (context, index) {
                return _DoctorCardShimmer();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// DOCTOR IMAGE SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
            ),
          ),

          8.heightBox,

          /// DOCTOR NAME SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 14,
              color: Colors.grey[300],
            ),
          ),

          6.heightBox,

          /// SPECIALIZATION SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 80,
              height: 12,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}