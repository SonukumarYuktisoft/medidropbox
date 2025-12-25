part of 'hospital_detail_bloc.dart';

sealed class HospitalDetailState extends Equatable {
  const HospitalDetailState();
  
  @override
  List<Object> get props => [];
}

final class HospitalDetailInitial extends HospitalDetailState {}
