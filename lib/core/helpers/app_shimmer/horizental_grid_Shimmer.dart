
import 'package:flutter/material.dart';
import 'package:medidropbox/core/extensions/space_extension.dart';
import 'package:medidropbox/core/helpers/app_shimmer/app_shimmers.dart';

class HorizentalGridShimmer extends StatelessWidget {
  final int count;
  final double height;
  final double width;
  final double horizontalP;
  final double verticalP;
  const HorizentalGridShimmer({
    super.key,
    this.count = 10,
    this.height = 150,
    this.width = 110,
    this.horizontalP = 10,
    this.verticalP = 10,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    child: ShimmerLoading(
      isLoading: true,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          // childAspectRatio: 0.7,
          mainAxisExtent: width,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalP,
          vertical: verticalP,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: count,
        physics: ScrollPhysics(),
        itemBuilder: (_, i) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ShimmerPlaceholders.rectangularShimmer(borderRadius: 8),
            ),
            5.heightBox,
            ShimmerPlaceholders.rectangularShimmer(
              height: 10,
              borderRadius: 8,
              width: width / 2,
            ),
            5.heightBox,
            ShimmerPlaceholders.rectangularShimmer(
              height: 10,
              borderRadius: 8,
              width: width / 1.2,
            ),
          ],
        ),
      ),
    ),
  );
}
