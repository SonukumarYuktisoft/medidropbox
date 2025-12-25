part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({this.tabPosition = 0, this.hospitalId});
  final int tabPosition;
  final AllHospitalModel? hospitalId;
  DashboardState copyWith({int? tabPosition, AllHospitalModel? hospitalId}) =>
      DashboardState(
        tabPosition: tabPosition ?? this.tabPosition,
        hospitalId: hospitalId ?? this.hospitalId,
      );
  @override
  List<Object?> get props => [tabPosition, hospitalId];
}
