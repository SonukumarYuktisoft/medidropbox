part of 'doctor_tab_bloc.dart';

class DoctorTabState extends Equatable {
  const DoctorTabState({
    this.mess = '',
    this.search = '',
    this.specialty = '',
    this.minRating = '',
    this.maxRating = '',
    this.minFees = '',
    this.maxFees = '',
    this.allowRemote = '',
    this.isActive = true,
    this.doctorStatus = ApiStatus.initial,
    this.pageStatus = ApiStatus.initial,
    this.doctorList
  });

  final String mess;
  final String search;
  final String specialty;
  final String minRating;
  final String maxRating;
  final String minFees;
  final String maxFees;
  final String allowRemote;
  final bool isActive;

  final ApiStatus doctorStatus;
  final ApiStatus pageStatus;
  final List<AllDoctorsModel>? doctorList;

  DoctorTabState copyWith({
    String? mess,
    String? search,
    String? specialty,
    String? minRating,
    String? maxRating,
    String? minFees,
    String? maxFees,
    String? allowRemote,
    bool? isActive,
    ApiStatus? doctorStatus,
    ApiStatus? pageStatus,
    List<AllDoctorsModel>? doctorList,
  }) {
    return DoctorTabState(
      mess: mess ?? this.mess,
      search: search ?? this.search,
      specialty: specialty ?? this.specialty,
      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,
      minFees: minFees ?? this.minFees,
      maxFees: maxFees ?? this.maxFees,
      allowRemote: allowRemote ?? this.allowRemote,
      isActive: isActive ?? this.isActive,
      doctorStatus: doctorStatus ?? this.doctorStatus,
      pageStatus: pageStatus ?? this.pageStatus,
      doctorList: doctorList ?? this.doctorList,
    );
  }

  @override
  List<Object?> get props => [
        mess,
        search,
        specialty,
        minRating,
        maxRating,
        minFees,
        maxFees,
      
        allowRemote,
        isActive,
        doctorStatus,
        pageStatus,
        doctorList
      ];
}
