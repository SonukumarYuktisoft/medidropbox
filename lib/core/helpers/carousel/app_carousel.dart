import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medidropbox/app/dashboard/tabs/doctor_tab/widgets/doctor_profile_card.dart';

// ============================================
// REUSABLE CAROUSEL WIDGET WITH INDICATORS
// ============================================
class AppCarousel extends StatefulWidget {
  /// List of widgets to display in carousel
  final List<Widget> items;

  /// Height of carousel
  final double height;

  /// Auto play carousel
  final bool autoPlay;

  /// Auto play duration
  final Duration autoPlayDuration;

  /// Animation duration
  final Duration animationDuration;

  /// Show indicators
  final bool showIndicators;

  /// Indicator position
  final IndicatorPosition indicatorPosition;

  /// Active indicator color
  final Color activeIndicatorColor;

  /// Inactive indicator color
  final Color inactiveIndicatorColor;

  /// Indicator size
  final double indicatorSize;

  /// Spacing between indicators
  final double indicatorSpacing;

  /// Border radius
  final double borderRadius;

  /// Padding around carousel
  final EdgeInsets? padding;

  /// View port fraction (how much of next item to show)
  final double viewportFraction;

  /// Enable infinite scroll
  final bool enableInfiniteScroll;

  /// On page changed callback
  final Function(int index)? onPageChanged;

  const AppCarousel({
    super.key,
    required this.items,
    this.height = 200,
    this.autoPlay = true,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 500),
    this.showIndicators = true,
    this.indicatorPosition = IndicatorPosition.bottom,
    this.activeIndicatorColor = Colors.blue,
    this.inactiveIndicatorColor = Colors.grey,
    this.indicatorSize = 8,
    this.indicatorSpacing = 8,
    this.borderRadius = 0,
    this.padding,
    this.viewportFraction = 1.0,
    this.enableInfiniteScroll = true,
    this.onPageChanged,
  });

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  late PageController _pageController;
  late ValueNotifier<int> _currentPageNotifier;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _currentPageNotifier = ValueNotifier<int>(0);
    _pageController = PageController(
      viewportFraction: widget.viewportFraction,
    );

    if (widget.autoPlay && widget.items.length > 1) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(widget.autoPlayDuration, (timer) {
      if (!mounted) return;

      int nextPage = _currentPageNotifier.value + 1;

      if (widget.enableInfiniteScroll) {
        if (nextPage >= widget.items.length) {
          nextPage = 0;
        }
      } else {
        if (nextPage >= widget.items.length) {
          timer.cancel();
          return;
        }
      }

      _pageController.animateToPage(
        nextPage,
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: Text('No items')),
      );
    }

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          if (widget.indicatorPosition == IndicatorPosition.top &&
              widget.showIndicators)
            _buildIndicators(),
          if (widget.indicatorPosition == IndicatorPosition.top &&
              widget.showIndicators)
            const SizedBox(height: 12),
          _buildCarousel(),
          if (widget.indicatorPosition == IndicatorPosition.bottom &&
              widget.showIndicators)
            const SizedBox(height: 12),
          if (widget.indicatorPosition == IndicatorPosition.bottom &&
              widget.showIndicators)
            _buildIndicators(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: widget.height,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _stopAutoPlay();
          } else if (notification is ScrollEndNotification) {
            if (widget.autoPlay && widget.items.length > 1) {
              _startAutoPlay();
            }
          }
          return false;
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.enableInfiniteScroll ? null : widget.items.length,
          onPageChanged: (index) {
            final actualIndex = index % widget.items.length;
            _currentPageNotifier.value = actualIndex;
            widget.onPageChanged?.call(actualIndex);
          },
          itemBuilder: (context, index) {
            final actualIndex = index % widget.items.length;
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.viewportFraction < 1.0 ? 8.0 : 0.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: widget.items[actualIndex],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPageNotifier,
      builder: (context, currentPage, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(
                horizontal: widget.indicatorSpacing / 2,
              ),
              width: currentPage == index
                  ? widget.indicatorSize * 2
                  : widget.indicatorSize,
              height: widget.indicatorSize,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? widget.activeIndicatorColor
                    : widget.inactiveIndicatorColor,
                borderRadius: BorderRadius.circular(widget.indicatorSize / 2),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================
// INDICATOR POSITION ENUM
// ============================================
enum IndicatorPosition {
  top,
  bottom,
}
