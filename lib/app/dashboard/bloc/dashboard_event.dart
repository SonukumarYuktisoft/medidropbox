part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class OnChangedTapPosition extends DashboardEvent {
  const OnChangedTapPosition(this.tabPosition);
  final int tabPosition;
  @override
  List<Object> get props => [tabPosition];
}
