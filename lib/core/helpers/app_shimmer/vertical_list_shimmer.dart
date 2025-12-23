import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/app_shimmers.dart';

class VerticalListShimmer extends StatefulWidget {
  final double? height;
  final bool shrinkWrap;
  final int? count;
  const VerticalListShimmer({
    super.key,
    this.height,
    this.shrinkWrap = false,
    this.count,
  });

  @override
  State<VerticalListShimmer> createState() => _VerticalListShimmerState();
}

class _VerticalListShimmerState extends State<VerticalListShimmer> {
  @override
  Widget build(BuildContext context) => ShimmerLoading(
    isLoading: true,
    child: ListView.builder(
      padding: EdgeInsets.all(10),
      shrinkWrap: widget.shrinkWrap,
      itemCount: widget.count ?? 10,
      physics: widget.shrinkWrap
          ? NeverScrollableScrollPhysics()
          : ScrollPhysics(),
      itemBuilder: (_, i) => ShimmerPlaceholders.rectangularShimmer(
        height: widget.height ?? 110,
        width: double.infinity,
        borderRadius: 8,
      ).paddingOnly(top: i != 0 ? 15 : 0),
    ),
  );
}
