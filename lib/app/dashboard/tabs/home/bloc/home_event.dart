part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class OnGetAllHospital extends HomeEvent {}

class OnGetHospitalById extends HomeEvent {
  final String id;

  const OnGetHospitalById(this.id);

  @override
  List<Object> get props => [id];
}

class OnGetAllDoctors extends HomeEvent {
  final String hospitalId;

  const OnGetAllDoctors(this.hospitalId);

  @override
  List<Object> get props => [hospitalId];
}

class OnGetDoctorById extends HomeEvent {
  final String doctorId;

  const OnGetDoctorById(this.doctorId);

  @override
  List<Object> get props => [doctorId];
}

class OnLoadMoreHospitals extends HomeEvent {}

class OnFilterHospitals extends HomeEvent {
  final Map<String, dynamic> filters;

  const OnFilterHospitals(this.filters);

  @override
  List<Object> get props => [filters];
}

class OnSearchHospitals extends HomeEvent {
  final String searchQuery;

  const OnSearchHospitals(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}

class OnResetHospitalFilters extends HomeEvent {}