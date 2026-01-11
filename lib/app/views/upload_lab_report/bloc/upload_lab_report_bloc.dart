import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:medidropbox/app/models/lab_report/lab_report_model.dart';
import 'package:medidropbox/app/repository/lab_report/lab_report_repo.dart';
import 'package:medidropbox/app/services/api_response_handler.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';

part 'upload_lab_report_event.dart';
part 'upload_lab_report_state.dart';

class UploadLabReportBloc extends Bloc<UploadLabReportEvent, UploadLabReportState> {
  final LabReportRepo repo;
  UploadLabReportBloc(this.repo) : super(UploadLabReportState()) {
    on<OnUploadLabReport>(_onUploadLabReportState);
    on<GetLabReportApi>(_onGetLabReportApi);
    on<GetLabReportByIdApi>(_onGetLabReportByIdApi);
  }
  Future<void> _onUploadLabReportState(
    OnUploadLabReport event,
    Emitter<UploadLabReportState> emit,
  ) async {
    emit(state.copyWith(status: ApiStatus.loading));
      final formData = FormData.fromMap({
      "reportType": event.reportType,   // text field
      "reportDate": event.date,   // text field
      "doctorName": event.doctorName,   // text field
      "labName": event.labName,   // text field
      "aiSummary": event.aiSummary,   // text field
       "notes":event.notes,
      /// 📎 File upload
      "file": await MultipartFile.fromFile(
        event.labReportFile,
        filename: event.labReportFile.split('/').last,
      ),
    });

   
    try {
      final res = await repo.uploadLabReport(formData);
      ApiResponseHandler.handle(
        emit: emit,
        state: state,
        response: res,
        parser: (data) =>data,
        onSuccess: (state, mess, data) => state.copyWith(
          status: ApiStatus.success,
          mess: mess,
        ),
        onError: (state, mess) =>
            state.copyWith(status: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(status: ApiStatus.error, mess: e.toString()));
    }
  }

  Future<void> _onGetLabReportApi(
    GetLabReportApi event,
    Emitter<UploadLabReportState> emit,
  ) async {
    emit(state.copyWith(labReportStatus: ApiStatus.loading));
    try {
      final res = await repo.getLabReport();
      ApiResponseHandler.handle<List<LabReportModel>,UploadLabReportState>(
        emit: emit,
        state: state,
        response: res,
        parser: (data) =>labReportModelFromJson(jsonEncode(data)),
        onSuccess: (state, mess, data) => state.copyWith(
          labReportStatus: ApiStatus.success,
          mess: mess,
          labReportList: data
        ),
        onError: (state, mess) =>
            state.copyWith(labReportStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(labReportStatus: ApiStatus.error, mess: e.toString()));
    }
  }

  Future<void> _onGetLabReportByIdApi(
    GetLabReportByIdApi event,
    Emitter<UploadLabReportState> emit,
  ) async {
    emit(state.copyWith(labReportDetailsStatus: ApiStatus.loading));
    try {
      final res = await repo.getLabReportById(event.id);
      ApiResponseHandler.handle<LabReportModel,UploadLabReportState>(
        emit: emit,
        state: state,
        response: res,
        parser: (data) =>LabReportModel.fromJson(data),
        onSuccess: (state, mess, data) => state.copyWith(
          labReportDetailsStatus: ApiStatus.success,
          mess: mess,
          labReportDetails: data
        ),
        onError: (state, mess) =>
            state.copyWith(labReportDetailsStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(labReportDetailsStatus: ApiStatus.error, mess: e.toString()));
    }
  }

}
