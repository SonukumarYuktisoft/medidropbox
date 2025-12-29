import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medidropbox/app/dashboard/tabs/doctor_tab/widgets/doctor_profile_card.dart';

// ============================================
// MULTIPLE ITEMS CAROUSEL (Shows multiple cards at once)
// ============================================
class AppMultiItemCarousel<T> extends StatefulWidget {
  /// List of data to display
  final List<T> dataList;

  /// Builder function for each item
  final Widget Function(T data, int index) itemBuilder;

  /// Height of carousel
  final double height;

  /// Width of each item card
  final double itemWidth;

  /// Auto play carousel
  final bool autoPlay;

  /// Auto play duration
  final Duration autoPlayDuration;

  /// Show indicators
  final bool showIndicators;

  /// Active indicator color
  final Color activeIndicatorColor;

  /// Inactive indicator color
  final Color inactiveIndicatorColor;

  /// Padding around carousel
  final EdgeInsets? padding;

  /// Spacing between items
  final double itemSpacing;

  /// On item tap callback
  final Function(T data, int index)? onItemTap;

  const AppMultiItemCarousel({
    super.key,
    required this.dataList,
    required this.itemBuilder,
    this.height = 200,
    this.itemWidth = 300,
    this.autoPlay = true,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.showIndicators = true,
    this.activeIndicatorColor = Colors.blue,
    this.inactiveIndicatorColor = Colors.grey,
    this.padding,
    this.itemSpacing = 16,
    this.onItemTap,
  });

  @override
  State<AppMultiItemCarousel<T>> createState() => _AppMultiItemCarouselState<T>();
}

class _AppMultiItemCarouselState<T> extends State<AppMultiItemCarousel<T>> {
  late ScrollController _scrollController;
  late ValueNotifier<int> _currentPageNotifier;
  Timer? _autoScrollTimer;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    _currentPageNotifier = ValueNotifier<int>(0);
    _scrollController = ScrollController();

    if (widget.autoPlay && widget.dataList.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(widget.autoPlayDuration, (timer) {
      if (!mounted || _isUserScrolling) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      final itemScrollWidth = widget.itemWidth + widget.itemSpacing;

      if (currentScroll >= maxScroll) {
        // Jump back to start
        _scrollController.jumpTo(0);
        _currentPageNotifier.value = 0;
      } else {
        // Scroll to next item
        final nextScroll = currentScroll + itemScrollWidth;
        final nextPage = (nextScroll / itemScrollWidth).round();
        
        _scrollController.animateTo(
          nextScroll.clamp(0.0, maxScroll),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        
        _currentPageNotifier.value = nextPage.clamp(0, widget.dataList.length - 1);
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  void _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      _isUserScrolling = true;
      _stopAutoScroll();
    } else if (notification is ScrollEndNotification) {
      _isUserScrolling = false;
      
      // Calculate current page based on scroll position
      final itemScrollWidth = widget.itemWidth + widget.itemSpacing;
      final currentPage = (_scrollController.offset / itemScrollWidth).round();
      _currentPageNotifier.value = currentPage.clamp(0, widget.dataList.length - 1);
      
      if (widget.autoPlay && widget.dataList.length > 1) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && !_isUserScrolling) {
            _startAutoScroll();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _scrollController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: Text('No items')),
      );
    }

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(
            height: widget.height,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                _onScrollNotification(notification);
                return false;
              },
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.dataList.length,
                separatorBuilder: (context, index) => SizedBox(width: widget.itemSpacing),
                itemBuilder: (context, index) {
                  final data = widget.dataList[index];
                  return SizedBox(
                    width: widget.itemWidth,
                    child: GestureDetector(
                      onTap: () => widget.onItemTap?.call(data, index),
                      child: widget.itemBuilder(data, index),
                    ),
                  );
                },
              ),
            ),
          ),
          if (widget.showIndicators) ...[
            const SizedBox(height: 12),
            _buildIndicators(),
          ],
        ],
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
            widget.dataList.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? widget.activeIndicatorColor
                    : widget.inactiveIndicatorColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================
// USAGE EXAMPLES
// ============================================

// Example 1: Doctor Cards Carousel (Shows all doctors, scrolls one by one)
class DoctorCarouselExample extends StatelessWidget {
  final List<dynamic> doctors; // Your DoctorModel list

  const DoctorCarouselExample({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return AppMultiItemCarousel(
      dataList: doctors,
      height: MediaQuery.of(context).size.height * 0.2,
      itemWidth: MediaQuery.of(context).size.width * 0.85,
      autoPlay: true,
      autoPlayDuration: const Duration(seconds: 3),
      showIndicators: true,
      activeIndicatorColor: Colors.blue,
      inactiveIndicatorColor: Colors.grey.shade300,
      itemSpacing: 16,
      itemBuilder: (doctor, index) {
        return DoctorProfileCard(doctor: doctor);
      },
      onItemTap: (doctor, index) {
        print('Tapped on doctor: ${doctor.name}');
      },
    );
  }
}

// Example 2: Product Cards
class ProductCarouselExample extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductCarouselExample({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return AppMultiItemCarousel(
      dataList: products,
      height: 180,
      itemWidth: 150,
      autoPlay: true,
      showIndicators: true,
      itemSpacing: 12,
      itemBuilder: (product, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag, size: 50, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                product['name'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Example 3: Image Gallery
class ImageGalleryCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const ImageGalleryCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return AppMultiItemCarousel(
      dataList: imageUrls,
      height: 250,
      itemWidth: MediaQuery.of(context).size.width * 0.9,
      autoPlay: true,
      autoPlayDuration: const Duration(seconds: 4),
      showIndicators: true,
      activeIndicatorColor: Colors.white,
      inactiveIndicatorColor: Colors.white.withOpacity(0.5),
      itemSpacing: 16,
      itemBuilder: (url, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey.shade200,
                child: const Icon(Icons.error, size: 50),
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================
// HOW TO USE IN YOUR CODE
// ============================================

/*
// Replace your ListView with this:

AppMultiItemCarousel(
  dataList: state.allDoctorList!,
  height: MediaQuery.of(context).size.height * 0.2,
  itemWidth: MediaQuery.of(context).size.width * 0.85,
  autoPlay: true,
  autoPlayDuration: const Duration(seconds: 3),
  showIndicators: true,
  activeIndicatorColor: Colors.blue,
  inactiveIndicatorColor: Colors.grey.shade300,
  itemSpacing: 16,
  padding: const EdgeInsets.symmetric(horizontal: 16),
  itemBuilder: (doctor, index) {
    return DoctorProfileCard(doctor: doctor);
  },
  onItemTap: (doctor, index) {
    // Optional: Handle tap on doctor card
    print('Tapped doctor: ${doctor.name}');
  },
)

// This will:
// ✅ Show ALL doctors in the list
// ✅ Auto-scroll through them one by one (right to left)
// ✅ Show animated dot indicators
// ✅ Pause on user interaction
// ✅ Resume auto-scroll after user stops scrolling
// ✅ Loop back to start when reaching the end
*/