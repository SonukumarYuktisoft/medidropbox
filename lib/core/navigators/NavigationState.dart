import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final bool showBottomNav;
  final int currentIndex;

  const NavigationState({
    this.showBottomNav = true,
    this.currentIndex = 0,
  });

  NavigationState copyWith({
    bool? showBottomNav,
    int? currentIndex,
  }) {
    return NavigationState(
      showBottomNav: showBottomNav ?? this.showBottomNav,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [showBottomNav, currentIndex];
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void showBottomNavigation() {
    emit(state.copyWith(showBottomNav: true));
  }

  void hideBottomNavigation() {
    emit(state.copyWith(showBottomNav: false));
  }

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}