import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_shimmer/app_shimmers.dart';

class BoxShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const BoxShimmer({
    super.key,
    this.height = 150,
    this.width = double.infinity,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) => ShimmerLoading(
    isLoading: true,
    child: ShimmerPlaceholders.rectangularShimmer(
      height: height,
      width: width,
      borderRadius: radius,
    ),
  );
}
