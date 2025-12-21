part of 'dashboard_bloc.dart';

 class DashboardState extends Equatable {
  const DashboardState({this.tabPosition=0});
  final int tabPosition;
DashboardState copyWith({
  int? tabPosition,
})=>DashboardState(
  tabPosition: tabPosition??this.tabPosition
);
  @override
  List<Object> get props => [tabPosition];
}

