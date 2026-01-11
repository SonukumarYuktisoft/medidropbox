part of 'upload_lab_report_bloc.dart';

 abstract class UploadLabReportEvent extends Equatable {
  const UploadLabReportEvent();
  @override
  List<Object> get props => [];
}

class OnUploadLabReport extends UploadLabReportEvent{
  const OnUploadLabReport({
    required this.aiSummary,
    required this.labName,
    required this.labReportFile,
    required this.date,
    required this.doctorName,
    required this.notes,
    required this.reportType,

  });
  final String reportType;
  final String labReportFile;
  final String date;
  final String doctorName;
  final String labName;
  final String aiSummary;
  final String notes;
    @override
  List<Object> get props => [
    reportType,
  labName,labReportFile,date,aiSummary,notes,doctorName
  ];
}


class GetLabReportApi extends UploadLabReportEvent {}

class GetLabReportByIdApi extends UploadLabReportEvent {
   const GetLabReportByIdApi(this.id);
  final String id;
  @override
  List<Object> get props => [id];
}










