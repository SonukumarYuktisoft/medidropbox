part of 'home_bloc.dart';

 class HomeState extends Equatable {
  const HomeState({
    this.mess = '',
    this.allHospitalSatatus =ApiStatus.initial,
    this.allHospitalList,
  });
  final String mess;
  final ApiStatus allHospitalSatatus;
  final List<AllHospitalModel>? allHospitalList;

  HomeState copyWith({
    String? mess,
   ApiStatus? allHospitalSatatus,
   List<AllHospitalModel>? allHospitalList,
  })=>HomeState(
    mess: mess??this.mess,
    allHospitalSatatus:allHospitalSatatus??this.allHospitalSatatus,
    allHospitalList:allHospitalList??this.allHospitalList,

  );
  @override
  List<Object?> get props => [mess,allHospitalSatatus,allHospitalList];
}

