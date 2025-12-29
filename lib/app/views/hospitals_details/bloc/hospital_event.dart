part of 'hospital_bloc.dart';

sealed class HospitalEvent extends Equatable {
  const HospitalEvent();

  @override
  List<Object?> get props => [];
}

class ToggleHospitalDetails extends HospitalEvent {}
