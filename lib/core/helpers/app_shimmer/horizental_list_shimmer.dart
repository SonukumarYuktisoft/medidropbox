
import 'package:flutter/material.dart';
import 'package:medidropbox/core/extensions/padding_extension.dart';
import 'package:medidropbox/core/helpers/app_shimmer/app_shimmers.dart';

class HorizentalListShimmer extends StatefulWidget {
  final double? height;
  final double? width;
  final int? count;
  final double horizontalMargin;
  final double gap;
  const HorizentalListShimmer({
    super.key,
    this.height = 100,
    this.width = 100,
    this.count,
    this.horizontalMargin = 0,
    this.gap = 15,
  });

  @override
  State<HorizentalListShimmer> createState() => _HorizentalListShimmerState();
}

class _HorizentalListShimmerState extends State<HorizentalListShimmer> {
  @override
  Widget build(BuildContext context) => ShimmerLoading(
    isLoading: true,
    child: SizedBox(
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
        itemCount: widget.count ?? 10,
        itemBuilder: (_, i) => ShimmerPlaceholders.rectangularShimmer(
          height: double.infinity,
          width: widget.width,
          borderRadius: 8,
        ).paddingOnly(left: i != 0 ? widget.gap : 0),
      ),
    ),
  );
}
