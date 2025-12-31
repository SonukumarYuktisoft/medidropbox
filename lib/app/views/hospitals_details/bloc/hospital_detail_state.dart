part of 'hospital_detail_bloc.dart';

class HospitalDetailState extends Equatable {
  const HospitalDetailState({
    this.hospitalDetail,
    this.hospitalDetailStatus = ApiStatus.initial,
    this.mess = '',
    this.allDoctorStatus = ApiStatus.initial,
    this.allDoctorList,
    this.selectedDoctor,
  });

  final String mess;
  final ApiStatus hospitalDetailStatus;
  final HospitalDetailModel? hospitalDetail;

  final ApiStatus allDoctorStatus;
  final List<AllDoctorsModel>? allDoctorList;
  final AllDoctorsModel? selectedDoctor;

  HospitalDetailState copyWith({
    String? mess,
    ApiStatus? hospitalDetailStatus,
    HospitalDetailModel? hospitalDetail,

   ApiStatus? allDoctorStatus,
   List<AllDoctorsModel>? allDoctorList,
   AllDoctorsModel? selectedDoctor,
  }) {
    return HospitalDetailState(
      mess: mess ?? this.mess,
      hospitalDetailStatus:
          hospitalDetailStatus ?? this.hospitalDetailStatus,
      hospitalDetail: hospitalDetail ?? this.hospitalDetail,
      allDoctorStatus: allDoctorStatus ?? this.allDoctorStatus,
      allDoctorList: allDoctorList ?? this.allDoctorList,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,

    );
  }

  @override
  List<Object?> get props => [
        mess,
        hospitalDetailStatus,
        hospitalDetail,
        allDoctorList,
        allDoctorStatus,
        selectedDoctor
      ];
}
