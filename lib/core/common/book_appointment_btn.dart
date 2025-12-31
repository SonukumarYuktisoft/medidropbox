import 'package:flutter/services.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:shimmer/shimmer.dart';

class BookAppointmentBtn extends StatefulWidget {
  const BookAppointmentBtn({super.key});
  @override
  State<BookAppointmentBtn> createState() => _BookAppointmentBtnState();
}

class _BookAppointmentBtnState extends State<BookAppointmentBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _iconSlideAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    // Scale animation for gentle breathing effect
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Pulse animation for glow effect
    _pulseAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Icon slide animation
    _iconSlideAnimation = Tween<double>(begin: 0.0, end: 3.0).animate(
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
    return SafeArea(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: _pulseAnimation.value,
                    spreadRadius: _pulseAnimation.value / 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Base button with blue background
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            AppNavigators.pushNamed(AppRoutesName.bookAppointmentView);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.translate(
                                  offset: Offset(_iconSlideAnimation.value, 0),
                                  child: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Book Appointment",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingAll(10),
          );
        },
      ),
    );
  }
}