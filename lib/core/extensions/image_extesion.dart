import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension SafeFancyImageExtension on String? {
  /// Checks if the string is a valid image URL
  bool get isValidImageUrl {
    if (this == null ||
        this!.isEmpty ||
        this == "null" ||
        this == "undefined") {
      return false;
    }
    try {
      final uri = Uri.parse(this!);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// Returns a circular shimmer image.
  Widget toCircularImage({
    double size = 50,
    BoxFit? fit,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    Color? shimmerBackColor,
  }) {
    if (!isValidImageUrl) {
      return _buildCircularFallback(size: size);
    }

    return ClipOval(
      child: FancyShimmerImage(
        imageUrl: this!,
        width: size,
        height: size,
        boxFit: fit ?? BoxFit.cover,
        shimmerBaseColor: shimmerBaseColor,
        shimmerHighlightColor: shimmerHighlightColor,
        shimmerBackColor: shimmerBackColor,
        errorWidget: _buildCircularErrorWidget(size: size),
      ),
    );
  }

  /// Returns a shimmer image with custom border radius.
  Widget toRadiusImage({
    double width = 80,
    double height = 80,
    double radius = 10,
    BoxFit fit = BoxFit.cover,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    Color? shimmerBackColor,
  }) {
    if (!isValidImageUrl) {
      return _buildRadiusFallback(width: width, height: height, radius: radius);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FancyShimmerImage(
        imageUrl: this!,
        width: width,
        height: height,
        boxFit: fit,
        shimmerBaseColor: shimmerBaseColor,
        shimmerHighlightColor: shimmerHighlightColor,
        shimmerBackColor: shimmerBackColor,
        errorWidget: errorImage(width: width, height: height),
      ),
    );
  }

  /// Returns a shimmer image with top border radius.
  Widget toTopRadiusImage({
    double width = 80,
    double height = 80,
    double radius = 10,
    BoxFit fit = BoxFit.cover,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    Color? shimmerBackColor,
  }) {
    if (!isValidImageUrl) {
      return _buildTopRadiusFallback(
        width: width,
        height: height,
        radius: radius,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      child: FancyShimmerImage(
        imageUrl: this!,
        width: width,
        height: height,
        boxFit: fit,
        shimmerBaseColor: shimmerBaseColor,
        shimmerHighlightColor: shimmerHighlightColor,
        shimmerBackColor: shimmerBackColor,
        errorWidget: errorImage(width: width, height: height),
      ),
    );
  }

  /// Returns a shimmer image with bottom border radius.
  Widget toBottomRadiusImage({
    double width = 80,
    double height = 80,
    double radius = 10,
    BoxFit fit = BoxFit.cover,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    Color? shimmerBackColor,
  }) {
    if (!isValidImageUrl) {
      return _buildBottomRadiusFallback(
        width: width,
        height: height,
        radius: radius,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
      child: FancyShimmerImage(
        imageUrl: this!,
        width: width,
        height: height,
        boxFit: fit,
        shimmerBaseColor: shimmerBaseColor,
        shimmerHighlightColor: shimmerHighlightColor,
        shimmerBackColor: shimmerBackColor,
        errorWidget: errorImage(width: width, height: height),
      ),
    );
  }

  /// Returns a shimmer image without any border radius.
  Widget toImage({
    double width = 80,
    double height = 80,
    BoxFit fit = BoxFit.cover,
    Color? shimmerBaseColor,
    Color? color,
    Color? shimmerHighlightColor,
    Color? shimmerBackColor,
  }) {
    if (!isValidImageUrl) {
      return _buildImageFallback(width: width, height: height);
    }

    return FancyShimmerImage(
      imageUrl: this!,
      width: width,
      height: height,
      boxFit: fit,
      color: color,
      shimmerBaseColor: shimmerBaseColor,
      shimmerHighlightColor: shimmerHighlightColor,
      shimmerBackColor: shimmerBackColor,
      errorWidget: errorImage(width: width, height: height),
    );
  }

  // Error widget for failed image loads
  Widget errorImage({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      color: Colors.red.shade50,
      child: Icon(
        Icons.medical_services,
        size: (height * 0.5).clamp(16.0, 60.0),
        color: Colors.grey,
        shadows: [
          Shadow(
            color: Colors.red.shade200,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  // Fallback widgets for invalid/null URLs
  Widget _buildCircularFallback({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.medical_services,
        size: (size * 0.5).clamp(16.0, 40.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildRadiusFallback({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.medical_services,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildTopRadiusFallback({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.medical_services,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildBottomRadiusFallback({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.medical_services,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildImageFallback({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.medical_services,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildCircularErrorWidget({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.broken_image,
        size: (size * 0.5).clamp(16.0, 40.0),
        color: Colors.grey.shade500,
      ),
    );
  }
}

extension SafeAssetImageExtension on String? {
  /// Checks if the string is a valid asset path
  bool get isValidAsset {
    return this != null &&
        this!.isNotEmpty &&
        this != "null" &&
        this != "undefined";
  }

  /// Returns a circular asset image.
  Widget toCircularAssetImage({double size = 50, BoxFit fit = BoxFit.cover}) {
    if (!isValidAsset) {
      return _buildCircularFallback(size: size);
    }

    return ClipOval(
      child: Image.asset(
        this!,
        width: size,
        height: size,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildCircularErrorWidget(size: size),
      ),
    );
  }

  /// Returns an asset image with custom border radius.
  Widget toRadiusAssetImage({
    double width = 80,
    double height = 80,
    double radius = 10,
    BoxFit fit = BoxFit.cover,
  }) {
    if (!isValidAsset) {
      return _buildRadiusFallback(width: width, height: height, radius: radius);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        this!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorImage(width: width, height: height),
      ),
    );
  }

  /// Returns an asset image with top border radius.
  Widget toTopRadiusAssetImage({
    double width = 80,
    double height = 80,
    double radius = 10,
    BoxFit fit = BoxFit.cover,
  }) {
    if (!isValidAsset) {
      return _buildTopRadiusFallback(
        width: width,
        height: height,
        radius: radius,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      child: Image.asset(
        this!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorImage(width: width, height: height),
      ),
    );
  }

  /// Returns an asset image with bottom border radius.
  Widget toBottomRadiusAssetImage({
    double width = 80,
    double height = 80,
    double radius = 10,
    BoxFit fit = BoxFit.cover,
  }) {
    if (!isValidAsset) {
      return _buildBottomRadiusFallback(
        width: width,
        height: height,
        radius: radius,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
      child: Image.asset(
        this!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorImage(width: width, height: height),
      ),
    );
  }

  /// Returns an asset image without any border radius.
  Widget toAssetImage({
    double width = 80,
    double height = 80,
    BoxFit fit = BoxFit.cover,
  }) {
    if (!isValidAsset) {
      return _buildImageFallback(width: width, height: height);
    }

    return Image.asset(
      this!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => errorImage(width: width, height: height),
    );
  }

  // Error/fallback widgets for asset image
  Widget errorImage({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      color: Colors.red.shade50,
      child: Icon(
        Icons.broken_image,
        size: (height * 0.5).clamp(16.0, 60.0),
        color: Colors.grey,
      ),
    );
  }

  Widget _buildCircularFallback({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.image,
        size: (size * 0.5).clamp(16.0, 40.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildRadiusFallback({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.image,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildTopRadiusFallback({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.image,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildBottomRadiusFallback({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.image,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildImageFallback({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        Icons.image,
        size: ((width + height) / 4).clamp(16.0, 60.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildCircularErrorWidget({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.broken_image,
        size: (size * 0.5).clamp(16.0, 40.0),
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget toAssetSvgImage({
    double width = 80,
    double height = 80,
    BoxFit fit = BoxFit.cover,
  }) {
    if (!isValidAsset) {
      return _buildImageFallback(width: width, height: height);
    }

    return SvgPicture.asset(
      this!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => errorImage(width: width, height: height),
    );
  }

  Widget toNetworkSvgImage({
    double width = 80,
    double height = 80,
    BoxFit fit = BoxFit.cover,
  }) {
    if (!isValidAsset) {
      return _buildImageFallback(width: width, height: height);
    }

    return SvgPicture.network(
      this!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => errorImage(width: width, height: height),
    );
  }
}
