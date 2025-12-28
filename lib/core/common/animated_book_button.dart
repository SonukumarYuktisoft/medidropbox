import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class AnimatedBookButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String fees;

  const AnimatedBookButton({
    super.key,
    required this.onPressed,
    required this.fees,
  });

  @override
  State<AnimatedBookButton> createState() =>
      _AnimatedBookButtonState();
}

class _AnimatedBookButtonState extends State<AnimatedBookButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _pulseAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                  blurRadius: _pulseAnimation.value + 4,
                  spreadRadius: _pulseAnimation.value / 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  // Base button
                  FloatingActionButton.extended(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      widget.onPressed();
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(widget.fees),
                  ),
                  // Shimmer overlay
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Shimmer.fromColors(
                        baseColor: Colors.transparent,
                        highlightColor: Colors.white.withOpacity(0.3),
                        period: const Duration(milliseconds: 1500),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}