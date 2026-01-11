import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/app/services/shared_preferences_helper.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/utility/const/constants_string/onboarding_constants_string.dart';
import 'package:medidropbox/app/views/OnboardingScreen/bloc/onboarding_bloc.dart';
import 'package:medidropbox/app/views/OnboardingScreen/bloc/onboarding_event.dart';
import 'package:medidropbox/app/views/OnboardingScreen/bloc/onboarding_state.dart';
import 'package:medidropbox/app/views/OnboardingScreen/model/onboarding_model.dart';
import 'package:medidropbox/app/views/OnboardingScreen/view/Widget/onboarding_page.dart';
import 'package:medidropbox/navigator/app_navigators/app_navigators.dart' show AppNavigators;
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;

  final pages = [
    OnboardingModel(
      title: OnboardingConstantsString.onboardingTitle1,
      description: OnboardingConstantsString.onboardingDescription1,
      icon: Icons.favorite_rounded,
      secondaryIcons: [Icons.medical_services, Icons.local_hospital, Icons.health_and_safety],
      gradient: const [Color(0xFF667eea), Color(0xFF764ba2)],
      image: OnboardingConstantsString.onboardingImage1
    ),
    OnboardingModel(
      title: OnboardingConstantsString.onboardingTitle2,
      description: OnboardingConstantsString.onboardingDescription2,
      icon: Icons.calendar_month_rounded,
      secondaryIcons: [Icons.person_search, Icons.local_hospital_outlined, Icons.access_time],
      gradient: const [Color(0xFFf093fb), Color(0xFff5576c)],
      image: OnboardingConstantsString.onboardingImage2
    ),
    OnboardingModel(
      title: OnboardingConstantsString.onboardingTitle3,
      description: OnboardingConstantsString.onboardingDescription3,
      icon: Icons.assignment_rounded,
      secondaryIcons: [Icons.upload_file, Icons.science, Icons.biotech],
      gradient: const [Color(0xFF4facfe), Color(0xFF00f2fe)],
      image: OnboardingConstantsString.onboardingImage3
    ),
    OnboardingModel(
      title: OnboardingConstantsString.onboardingTitle4,
      description: OnboardingConstantsString.onboardingDescription4,
      icon: Icons.account_circle_rounded,
      secondaryIcons: [Icons.height, Icons.monitor_weight, Icons.bloodtype],
      gradient: const [Color(0xFF43e97b), Color(0xFF38f9d7)],
      image: OnboardingConstantsString.onboardingImage4
    ),
    OnboardingModel(
      title: OnboardingConstantsString.onboardingTitle5,
      description: OnboardingConstantsString.onboardingDescription5,
      icon: Icons.monitor_heart_rounded,
      secondaryIcons: [Icons.favorite, Icons.thermostat, Icons.air],
      gradient: const [Color(0xFFfa709a), Color(0xFFfee140)],
      image: OnboardingConstantsString.onboardingImage5
    ),
    OnboardingModel(
      title: OnboardingConstantsString.onboardingTitle6,
      description: OnboardingConstantsString.onboardingDescription6,
      icon: Icons.confirmation_number_rounded,
      secondaryIcons: [Icons.queue, Icons.schedule, Icons.notifications_active],
      gradient: const [Color(0xFF30cfd0), Color(0xFF330867)],
      image: OnboardingConstantsString.onboardingImage6
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (prev, curr) => curr.isCompleted,
        listener: (context, state) async {
          await SharedPreferencesHelper.setIsFirstTime(false);
          if (context.mounted) {
            AppNavigators.pushReplacementNamed(AppRoutesName.loginView);
          }
        },
        child: Scaffold(
          body: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Column(
                    children: [
                      // Skip button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,
                         vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (state.currentPage < pages.length - 1)
                              TextButton.icon(
                                onPressed: () {
                                  context.read<OnboardingBloc>().add(OnDonePressed());
                                },
                                icon: const Icon(Icons.skip_next,
                                 color: Colors.black),
                                label: const Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ).radiusContainerWithBorder(
                                height: 40
                              ),
                          ],
                        ),
                      ),
                
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pages.length,
                          onPageChanged: (index) {
                            context.read<OnboardingBloc>().add(
                              OnPageChanged(index),
                            );
                            _animationController.reset();
                            _animationController.forward();
                          },
                          itemBuilder: (context, index) {
                            return OnboardingPage(
                              model: pages[index],
                              animationController: _animationController,
                            );
                          },
                        ),
                      ),
                
                      // Page Indicators
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: state.currentPage == index ? 40 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: state.currentPage == index
                                    ? Colors.black
                                    : Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: state.currentPage == index
                                    ? [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.4),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : [],
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      
                      // Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 15),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.currentPage == pages.length - 1) {
                                context.read<OnboardingBloc>().add(
                                  OnDonePressed(),
                                );
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOutCubic,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: pages[state.currentPage].gradient[0],
                              elevation: 12,
                              shadowColor: Colors.black.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.currentPage == pages.length - 1
                                      ? "Get Started"
                                      : "Continue",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  state.currentPage == pages.length - 1
                                      ? Icons.check_circle_rounded
                                      : Icons.arrow_forward_rounded,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    
                    
                    
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}