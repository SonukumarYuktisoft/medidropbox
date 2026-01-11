part of 'health_profile_bloc.dart';

 class HealthProfileState extends Equatable {
  const HealthProfileState({
    this.mess = '',
    this.getHealthProfileData,
    this.getHealthProfileStatus = ApiStatus.initial,
    this.bmiData,
    this.bmiStatus = ApiStatus.initial,
    this.latestVitalData,
    this.latestVitalStatus = ApiStatus.initial,
        this.getVitalHistory,
    this.getVitalHistoryStatus = ApiStatus.initial,
    this.createVitalStatus = ApiStatus.initial,
    this.updateProfileStatus = ApiStatus.initial,
    this.creteVitalRes,
  });
  final ApiStatus createVitalStatus;
  final ApiStatus updateProfileStatus;
  final ApiStatus getVitalHistoryStatus;
  final List<VitalHistoryModel>? getVitalHistory;


  final String mess;
  final ApiStatus getHealthProfileStatus;
  final HealthProfileModel? getHealthProfileData;

    final ApiStatus bmiStatus;
  final BmiReportModel? bmiData;
final   LatestVitalModel? latestVitalData;
  final ApiStatus latestVitalStatus;
  final dynamic creteVitalRes;

  HealthProfileState copyWith({
    String? mess,
   ApiStatus? getHealthProfileStatus,
   ApiStatus? updateProfileStatus,
   ApiStatus? createVitalStatus,
   HealthProfileModel? getHealthProfileData,

   ApiStatus? bmiStatus,
   BmiReportModel? bmiData,
   LatestVitalModel? latestVitalData,
   ApiStatus? latestVitalStatus,
   ApiStatus? getVitalHistoryStatus,
   List<VitalHistoryModel>? getVitalHistory,
   dynamic creteVitalRes
  })=>HealthProfileState(
    mess: mess??this.mess,
    updateProfileStatus: updateProfileStatus??this.updateProfileStatus,
    getHealthProfileData: getHealthProfileData??this.getHealthProfileData,
    getHealthProfileStatus: getHealthProfileStatus??this.getHealthProfileStatus,
    bmiData: bmiData??this.bmiData,
    bmiStatus: bmiStatus??this.bmiStatus,
    latestVitalStatus: latestVitalStatus??this.latestVitalStatus,
    latestVitalData: latestVitalData??this.latestVitalData,

    getVitalHistoryStatus: getVitalHistoryStatus??this.getVitalHistoryStatus,
    getVitalHistory: getVitalHistory??this.getVitalHistory,
    createVitalStatus: createVitalStatus??this.createVitalStatus,
    creteVitalRes: creteVitalRes??this.creteVitalRes,

  );
  @override
  List<Object?> get props => [
    creteVitalRes,updateProfileStatus,
    mess,getHealthProfileStatus,getHealthProfileData,
  bmiStatus,bmiData,latestVitalStatus,latestVitalData,
  getVitalHistoryStatus,getVitalHistory,createVitalStatus
  ];
}

