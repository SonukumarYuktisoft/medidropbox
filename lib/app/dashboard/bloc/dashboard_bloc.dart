import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<OnChangedTapPosition>(_onChangeTabPosition);
  }
  void _onChangeTabPosition(OnChangedTapPosition event, Emitter<DashboardState> emit)=>emit(
    state.copyWith(tabPosition: event.tabPosition)
  );
}
