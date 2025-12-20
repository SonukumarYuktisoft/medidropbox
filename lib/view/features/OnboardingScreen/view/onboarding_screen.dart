import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/utility/const/constants_string/onboarding_constants_string.dart';
import 'package:medidropbox/view/features/OnboardingScreen/bloc/onboarding_bloc.dart';
import 'package:medidropbox/view/features/OnboardingScreen/bloc/onboarding_event.dart';
import 'package:medidropbox/view/features/OnboardingScreen/bloc/onboarding_state.dart';
import 'package:medidropbox/view/features/OnboardingScreen/model/onboarding_model.dart';
import 'package:medidropbox/view/features/OnboardingScreen/view/Widget/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  final pages = [
    OnboardingModel(
      title:OnboardingConstantsString.onboardingTitle1 ,
      description:OnboardingConstantsString.onboardingDescription1,
      image: OnboardingConstantsString.onboardingImage1,
    ),
    OnboardingModel(
    title:OnboardingConstantsString.onboardingTitle2 ,
      description:OnboardingConstantsString.onboardingDescription2,
      image: OnboardingConstantsString.onboardingImage2,
    ),
    OnboardingModel(
      title:OnboardingConstantsString.onboardingTitle3 ,
      description:OnboardingConstantsString.onboardingDescription3,
      image: OnboardingConstantsString.onboardingImage3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (prev, curr) => curr.isCompleted,
        listener: (context, state) {
          // TODO: Save onboarding completed in local storage
          // Navigator.pushReplacement(...)
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: pages.length,
                        onPageChanged: (index) {
                          context.read<OnboardingBloc>().add(
                            OnPageChanged(index),
                          );
                        },
                        itemBuilder: (context, index) {
                          return OnboardingPage(model: pages[index]);
                        },
                      ),
                    ),

                    /// Page Indicators
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: state.currentPage == index ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: state.currentPage == index
                                  ? const Color(0xFF4A7EFF)
                                  : const Color(0xFFD1D5DB),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),

                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     height: 56,
                    //     child: "Let's Get Started".toElevatedButton(
                    //       onPressed: () {},
                    //       radius: 28,
                    //     ),
                    //   ),
                    // ),

                    /// Button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (state.currentPage == pages.length - 1) {
                              context.read<OnboardingBloc>().add(
                                OnDonePressed(),
                              );
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A7EFF),
                            foregroundColor: Colors.white,
                            elevation: 0,              
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Let's Get Started",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
