part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class OnGetAllHospital extends HomeEvent {}

class OnSelecteHospitalData extends HomeEvent {
  const OnSelecteHospitalData(this.data);
  final AllHospitalModel data;
  @override
  List<Object> get props => [data];
}
