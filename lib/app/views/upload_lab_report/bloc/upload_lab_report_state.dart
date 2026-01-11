part of 'upload_lab_report_bloc.dart';

 class UploadLabReportState extends Equatable {
  const UploadLabReportState({
    this.status=ApiStatus.initial,
    this.mess='',
    this.labReportStatus=ApiStatus.initial,
    this.labReportList,
    this.labReportDetails,
    this.labReportDetailsStatus=ApiStatus.initial,

  });
  final String mess;
  final ApiStatus status;
  final ApiStatus labReportStatus;
  final ApiStatus labReportDetailsStatus;
  final LabReportModel? labReportDetails;
  final List<LabReportModel>? labReportList;
  UploadLabReportState copyWith({
   String? mess,
   ApiStatus ?status,
   ApiStatus? labReportStatus,
   List<LabReportModel>? labReportList,
   ApiStatus? labReportDetailsStatus,
   LabReportModel? labReportDetails,
  })=>UploadLabReportState(
    mess: mess??this.mess,
    status: status??this.status,
    labReportStatus: labReportStatus??this.labReportStatus,
    labReportList: labReportList??this.labReportList,
    labReportDetails: labReportDetails??this.labReportDetails,
    labReportDetailsStatus: labReportDetailsStatus??this.labReportDetailsStatus,
  );
  @override
  List<Object?> get props => [mess,status,labReportStatus,labReportList,
  labReportDetailsStatus,labReportDetails];
}

