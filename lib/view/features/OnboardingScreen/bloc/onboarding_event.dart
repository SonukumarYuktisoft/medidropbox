abstract class OnboardingEvent {}

class OnPageChanged extends OnboardingEvent {
  final int index;
  OnPageChanged(this.index);
}

class OnNextPressed extends OnboardingEvent {}

class OnSkipPressed extends OnboardingEvent {}

class OnDonePressed extends OnboardingEvent {}
