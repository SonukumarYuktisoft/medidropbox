part of 'hospital_detail_bloc.dart';

abstract class HospitalDetailEvent extends Equatable {
  const HospitalDetailEvent();

  @override
  List<Object> get props => [];
}

class OnHospitalDetails extends HospitalDetailEvent {}
