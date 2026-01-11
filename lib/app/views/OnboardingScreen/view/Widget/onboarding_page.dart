
import 'package:medidropbox/app/views/OnboardingScreen/model/onboarding_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingModel model;
  final AnimationController animationController;

  const OnboardingPage({
    super.key,
    required this.model,
    required this.animationController,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeOutCubic,
    ));

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeIn,
    ));

    final scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.elasticOut,
    ));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Main animated icon with floating secondary icons
          FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: SizedBox(
                height: 350,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Image.network(widget.model.image.toString(),
                    // height: 50,width: 50
                    // ,),
                    widget.model.image.toString().toImage(
                      height: double.infinity,
                      width: double.infinity
                    )
                   /*  
                    // Rotating secondary icons
                    ...List.generate(widget.model.secondaryIcons.length, (index) {
                      final angle = (2 * math.pi / widget.model.secondaryIcons.length) * index;
                      return AnimatedBuilder(
                        animation: _rotationController,
                        builder: (context, child) {
                          final rotationAngle = angle + (_rotationController.value * 2 * math.pi);
                          return Transform.translate(
                            offset: Offset(
                              math.cos(rotationAngle) * 120,
                              math.sin(rotationAngle) * 120,
                            ),
                            child: child,
                          );
                        },
                        child: AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            final scale = 1.0 + (_pulseController.value * 0.2);
                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  widget.model.secondaryIcons[index],
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    // Pulsing background circles
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          width: 200 + (_pulseController.value * 30),
                          height: 200 + (_pulseController.value * 30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3 - (_pulseController.value * 0.2)),
                              width: 2,
                            ),
                          ),
                        );
                      },
                    ),

                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          width: 160 + (_pulseController.value * 20),
                          height: 160 + (_pulseController.value * 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4 - (_pulseController.value * 0.2)),
                              width: 2,
                            ),
                          ),
                        );
                      },
                    ),

                    // Main icon container
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final scale = 1.0 + (_pulseController.value * 0.05);
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.4),
                                  blurRadius: 20,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.model.icon,
                              size: 70,
                              color: widget.model.gradient[0],
                            ),
                          ),
                        );
                      },
                    ),
                  */ ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),

          // Title with slide animation
          SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Text(
                widget.model.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.3,
                  letterSpacing: -0.5,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Description with slide animation
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: widget.animationController,
              curve: Curves.easeOutCubic,
            )),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  widget.model.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    height: 1.6,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}