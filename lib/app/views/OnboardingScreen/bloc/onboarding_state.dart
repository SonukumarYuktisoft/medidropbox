class OnboardingState {
  final int currentPage;
  final bool isCompleted;

  OnboardingState({
    required this.currentPage,
    required this.isCompleted,
  });

  factory OnboardingState.initial() {
    return OnboardingState(
      currentPage: 0,
      isCompleted: false,
    );
  }

  OnboardingState copyWith({
    int? currentPage,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
