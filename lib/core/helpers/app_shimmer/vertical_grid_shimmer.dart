import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/app_shimmers.dart';
import 'package:shimmer/shimmer.dart';

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



class CardVerticalGridShimmer extends StatelessWidget {
  final int count;
  final int crossCount;
  final double cardHeight;
  final double horizontalPadding;
  final double verticalPadding;
  final bool shrinkWrap;
  final double crossSpacing;
  final double mainSpacing;

  const CardVerticalGridShimmer({
    Key? key,
    this.count = 10,
    this.crossCount = 2,
    this.cardHeight = 280,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.shrinkWrap = false,
    this.crossSpacing = 12,
    this.mainSpacing = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        mainAxisSpacing: mainSpacing,
        crossAxisSpacing: crossSpacing,
        mainAxisExtent: cardHeight,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      shrinkWrap: shrinkWrap,
      itemCount: count,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemBuilder: (context, index) => _buildShimmerCard(context),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
            ),
            
            // Content area
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title line 1
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Title line 2
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Subtitle/Description
                  Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Price area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 18,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
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
}
