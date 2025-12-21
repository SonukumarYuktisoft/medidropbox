import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medidropbox/app/views/OnboardingScreen/bloc/onboarding_event.dart';
import 'package:medidropbox/app/views/OnboardingScreen/bloc/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.initial()) {
    // on<OnPageChanged>((event, emit) {
    //   emit(state.copyWith(currentPage: event.index));
    // });

    // on<OnNextPressed>((event, emit) {
    //   emit(state.copyWith(currentPage: state.currentPage + 1));
    // });

    // on<OnSkipPressed>((event, emit) {
    //   emit(state.copyWith(isCompleted: true));
    // });

    // on<OnDonePressed>((event, emit) {
    //   emit(state.copyWith(isCompleted: true));
    // });

    on<OnPageChanged>(_onPageChanged);
    on<OnNextPressed>(_onNextPressed);
    on<OnSkipPressed>(_onSkipPressed);
    on<OnDonePressed>(_onDonePressed);
  }

  void _onPageChanged(OnPageChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: event.index));
  }

  void _onNextPressed(OnNextPressed event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void _onSkipPressed(OnSkipPressed event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(isCompleted: true));
  }

  void _onDonePressed(OnDonePressed event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(isCompleted: true));
  }
}
