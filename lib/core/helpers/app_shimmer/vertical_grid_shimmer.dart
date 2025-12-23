import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/app_shimmers.dart';

class VerticalGridShimmer extends StatelessWidget {
  final int count;
  final int crosCount;
  final double height;

  final double horizontalP;
  final double verticalP;
  final bool shrinkWrap;
  const VerticalGridShimmer({
    super.key,
    this.count = 10,
    this.crosCount = 1,
    this.height = 150,

    this.horizontalP = 10,
    this.verticalP = 10,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) => ShimmerLoading(
    isLoading: true,
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crosCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        // childAspectRatio: 0.7,
        mainAxisExtent: height,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalP,
        vertical: verticalP,
      ),
      shrinkWrap: shrinkWrap,
      itemCount: count,
      physics: shrinkWrap ? NeverScrollableScrollPhysics() : ScrollPhysics(),
      itemBuilder: (_, i) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ShimmerPlaceholders.rectangularShimmer(borderRadius: 8),
          ),
          5.heightBox,
          ShimmerPlaceholders.rectangularShimmer(
            height: 15,
            borderRadius: 5,
            width: MediaQuery.of(context).size.width / 2,
          ),
          5.heightBox,
          ShimmerPlaceholders.rectangularShimmer(
            height: 10,
            borderRadius: 5,
            width: MediaQuery.of(context).size.width / 1.7,
          ),
        ],
      ),
    ),
  );
}
