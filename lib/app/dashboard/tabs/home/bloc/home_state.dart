part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.mess = '',
    this.allHospitalStatus = ApiStatus.initial,
    this.allHospitalList,
    this.allDoctorStatus = ApiStatus.initial,
    this.allDoctorList,
    this.hospitalDetailStatus = ApiStatus.initial,
    this.hospitalDetail,
    this.doctorDetailStatus = ApiStatus.initial,
    this.doctorDetail,
    this.currentPage = 0,
    this.pageSize = 10,
    this.hasMoreHospitals = true,
    this.isLoadingMore = false,
    this.hospitalFilters,
    this.myQueueList,
    this.myQueueStatus=ApiStatus.initial,
    this.liveQueueStatus=ApiStatus.initial,
    this.liveQueueData
  });
  
  final String mess;
  final ApiStatus allHospitalStatus;
  final List<AllHospitalModel>? allHospitalList;
  final ApiStatus hospitalDetailStatus;
  final HospitalDetailModel? hospitalDetail;
  final ApiStatus allDoctorStatus;
  final List<AllDoctorsModel>? allDoctorList;
  final ApiStatus doctorDetailStatus;
  final DoctorDetailModel? doctorDetail;
  
  // Pagination and filter fields
  final int currentPage;
  final int pageSize;
  final bool hasMoreHospitals;
  final bool isLoadingMore;
  final Map<String, dynamic>? hospitalFilters;

  final List<MyQueueModel>?myQueueList;
  final ApiStatus myQueueStatus;
    final  LiveQueueModel? liveQueueData;
   final ApiStatus liveQueueStatus;

  HomeState copyWith({
    String? mess,
    ApiStatus? allHospitalStatus,
    List<AllHospitalModel>? allHospitalList,
    ApiStatus? allDoctorStatus,
    List<AllDoctorsModel>? allDoctorList,

    ApiStatus? doctorDetailStatus,
    DoctorDetailModel? doctorDetail,
    int? currentPage,
    int? pageSize,
    bool? hasMoreHospitals,
    bool? isLoadingMore,
    Map<String, dynamic>? hospitalFilters,

    List<MyQueueModel>?myQueueList,
    ApiStatus? myQueueStatus,
    LiveQueueModel?liveQueueData,
    ApiStatus? liveQueueStatus,
  }) => HomeState(
    mess: mess ?? this.mess,
    allHospitalStatus: allHospitalStatus ?? this.allHospitalStatus,
    allHospitalList: allHospitalList ?? this.allHospitalList,
    allDoctorStatus: allDoctorStatus ?? this.allDoctorStatus,
    allDoctorList: allDoctorList ?? this.allDoctorList,
    doctorDetailStatus: doctorDetailStatus ?? this.doctorDetailStatus,
    doctorDetail: doctorDetail ?? this.doctorDetail,
    currentPage: currentPage ?? this.currentPage,
    pageSize: pageSize ?? this.pageSize,
    hasMoreHospitals: hasMoreHospitals ?? this.hasMoreHospitals,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hospitalFilters: hospitalFilters ?? this.hospitalFilters,
    myQueueList: myQueueList ?? this.myQueueList,
    myQueueStatus: myQueueStatus ?? this.myQueueStatus,

    liveQueueData: liveQueueData ?? this.liveQueueData,
    liveQueueStatus: liveQueueStatus ?? this.liveQueueStatus,
  );
  
  @override
  List<Object?> get props => [
    liveQueueStatus,
    liveQueueData,
    myQueueList,
    myQueueStatus,
    mess,
    allHospitalStatus,
    allHospitalList,
    allDoctorStatus,
    allDoctorList,
    hospitalDetailStatus,
    hospitalDetail,
    doctorDetailStatus,
    doctorDetail,
    currentPage,
    pageSize,
    hasMoreHospitals,
    isLoadingMore,
    hospitalFilters,
  ];
}