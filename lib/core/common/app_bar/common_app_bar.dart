import 'package:flutter/material.dart';

class CommonHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  CommonHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return Material(
      elevation: overlapsContent ? 4 : 0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.lerp(
          EdgeInsets.all(16),
          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          progress,
        )!,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CommonHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}
