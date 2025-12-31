part of 'hospital_detail_bloc.dart';

abstract class HospitalDetailEvent extends Equatable {
  const HospitalDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetHospitalById extends HospitalDetailEvent {
  final String id;
  const OnGetHospitalById(this.id);
  @override
  List<Object> get props => [id];
}

class OnGetAllDoctorsByHospital extends HospitalDetailEvent {
  final String hospitalId;

  const OnGetAllDoctorsByHospital(this.hospitalId);

  @override
  List<Object> get props => [hospitalId];
}



class OnSelectDoctor extends HospitalDetailEvent {
  final AllDoctorsModel doc;
  const OnSelectDoctor(this.doc);
  @override
  List<Object> get props => [doc];
}