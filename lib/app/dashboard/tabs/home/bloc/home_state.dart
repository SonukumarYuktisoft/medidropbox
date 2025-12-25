part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.mess = '',
    this.allHospitalSatatus = ApiStatus.initial,
    this.allHospitalList,
    this.selectedHospital,
  });
  final String mess;
  final ApiStatus allHospitalSatatus;
  final List<AllHospitalModel>? allHospitalList;
  final AllHospitalModel? selectedHospital;

  HomeState copyWith({
    String? mess,
    ApiStatus? allHospitalSatatus,
    AllHospitalModel? selectedHospital,
    List<AllHospitalModel>? allHospitalList,
  }) => HomeState(
    mess: mess ?? this.mess,
    allHospitalSatatus: allHospitalSatatus ?? this.allHospitalSatatus,
    allHospitalList: allHospitalList ?? this.allHospitalList,
    selectedHospital: selectedHospital ?? this.selectedHospital,
  );
  @override
  List<Object?> get props => [
    mess,
    allHospitalSatatus,
    allHospitalList,
    selectedHospital,
  ];
}
