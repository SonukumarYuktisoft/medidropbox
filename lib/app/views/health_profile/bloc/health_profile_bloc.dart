import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medidropbox/app/models/health_profile/bmi_report_model.dart';
import 'package:medidropbox/app/models/health_profile/health_profile_model.dart';
import 'package:medidropbox/app/models/health_profile/latest_vital_model.dart';
import 'package:medidropbox/app/models/health_profile/vital_history_model.dart';
import 'package:medidropbox/app/repository/health_profile/health_profile_repo.dart';
import 'package:medidropbox/app/services/api_response_handler.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';

part 'health_profile_event.dart';
part 'health_profile_state.dart';

class HealthProfileBloc extends Bloc<HealthProfileEvent, HealthProfileState> {
  HealthProfileRepo repo;
  HealthProfileBloc(this.repo) : super(HealthProfileState()) {
    on<OnGetHealthProfile>(_onGetHealthProfile);
    on<OnBMIReportApi>(_onBMIReportApi);
    on<OnGetLatestVitalApi>(_onGetLatestVitalApi);
    on<OnGetVitalHistoryApi>(_onGetVitalHistoryApi);
    on<OnCreateVitalsEvent>(_onCreateVitalsEvent);
    on<OnEditVitalsEvent>(_onEditVitalsEvent);
    on<OnUpdateHealthProfileEvent>(_onUpdateHealthProfileEvent);
  }
  //OnEditVitalsEvent

  void _onGetHealthProfile(
    OnGetHealthProfile event,
    Emitter<HealthProfileState> emit,
  ) async {
    emit(state.copyWith(getHealthProfileStatus: ApiStatus.loading));
    try {
      final res = await repo.getHealthProfile();
      ApiResponseHandler.handle<HealthProfileModel, HealthProfileState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => healthProfileModelFromJson(jsonEncode(d)),
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          getHealthProfileData: data,
          getHealthProfileStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(getHealthProfileStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mess: e.toString(),
          getHealthProfileStatus: ApiStatus.error,
        ),
      );
    }
  }

  void _onBMIReportApi(
    OnBMIReportApi event,
    Emitter<HealthProfileState> emit,
  ) async {
    emit(state.copyWith(bmiStatus: ApiStatus.loading));
    try {
      final res = await repo.getBMIReport();
      ApiResponseHandler.handle<BmiReportModel, HealthProfileState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => bmiReportModelFromJson(jsonEncode(d)),
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          bmiData: data,
          bmiStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(bmiStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(mess: e.toString(), bmiStatus: ApiStatus.error));
    }
  }

  void _onGetLatestVitalApi(
    OnGetLatestVitalApi event,
    Emitter<HealthProfileState> emit,
  ) async {
    emit(state.copyWith(latestVitalStatus: ApiStatus.loading));
    try {
      final res = await repo.getLetestVital();
      ApiResponseHandler.handle<LatestVitalModel, HealthProfileState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => latestVitalModelFromJson(jsonEncode(d)),
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          latestVitalData: data,
          latestVitalStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(latestVitalStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), latestVitalStatus: ApiStatus.error),
      );
    }
  }

  Future<void> _onGetVitalHistoryApi(
    OnGetVitalHistoryApi event,
    Emitter<HealthProfileState> emit,
  ) async {
    emit(state.copyWith(getVitalHistoryStatus: ApiStatus.loading));
    try {
      var data = {"": ""};
      final res = await repo.getVitalHistory(data);
      ApiResponseHandler.handle<List<VitalHistoryModel>, HealthProfileState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) {
          print('🔵 Parsing data: $d');
          return vitalHistoryModelFromJson(jsonEncode(d));
        },
        onSuccess: (state, mess, data) {
          print('🟢 Success: ${data.length} records found');
          return state.copyWith(
            mess: mess,
            getVitalHistory: data,
            getVitalHistoryStatus: ApiStatus.success,
          );
        },
        onError: (state, mess) {
          print('🔴 Error: $mess');
          return state.copyWith(
            getVitalHistoryStatus: ApiStatus.error,
            mess: mess,
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          mess: e.toString(),
          getVitalHistoryStatus: ApiStatus.error,
        ),
      );
    }
  }

  void _onCreateVitalsEvent(
    OnCreateVitalsEvent event,
    Emitter<HealthProfileState> emit,
  ) async {
    emit(state.copyWith(createVitalStatus: ApiStatus.loading));
    print('🟡 Status: Loading create vitals');
    var d = {
      "weightKg": event.weightKg,
      "bloodGlucoseMgdl": event.bloodGlucoseMgdl,
      "bloodPressureSystolic": event.bloodPressureSystolic,
      "bloodPressureDiastolic": event.bloodPressureDiastolic,
      "recordedAt": event.recordedAt,
      "notes": event.notes,
    };
    try {
          print("==========$d=======");

      final res = await repo.createVitalRecord(d);
      ApiResponseHandler.handle(
        emit: emit,
        state: state,
        response: res,
        parser: (d) {
          print('🔵 Parsing data: $d');

          return d;
        },
        onSuccess: (state, mess, data) {
          log('🟢 Success: ${data.toString()} records foundv from create vatals');

          return state.copyWith(
            mess: mess,
            creteVitalRes: data,
            createVitalStatus: ApiStatus.success,
          );
        },
        onError: (state, mess) {
          print('🔴 Error: $mess');
          return state.copyWith(createVitalStatus: ApiStatus.error, mess: mess);
        },
      );
    } catch (e, stackTrace) {
      print('🔴 Exception: $e');
      print('🔴 StackTrace: $stackTrace');
      emit(
        state.copyWith(mess: e.toString(), createVitalStatus: ApiStatus.error),
      );
    }
  }




  void _onEditVitalsEvent(
    OnEditVitalsEvent event,
    Emitter<HealthProfileState> emit,
  ) async {
    emit(state.copyWith(createVitalStatus: ApiStatus.loading));
    print('🟡 Status: Loading create vitals');
    var d = {
      "weightKg": event.weightKg,
      "bloodGlucoseMgdl": event.bloodGlucoseMgdl,
      "bloodPressureSystolic": event.bloodPressureSystolic,
      "bloodPressureDiastolic": event.bloodPressureDiastolic,
      "notes": event.notes,
    };
    try {
      final res = await repo.updateVitalRecord(d,event.id);
      ApiResponseHandler.handle(
        emit: emit,
        state: state,
        response: res,
        parser: (d) {
          return d;
        },
        onSuccess: (state, mess, data) {
          return state.copyWith(
            mess: mess,
            creteVitalRes: data,
            createVitalStatus: ApiStatus.success,
          );
        },
        onError: (state, mess) {
          return state.copyWith(createVitalStatus: ApiStatus.error, mess: mess);
        },
      );
    } catch (e, stackTrace) {
      print('🔴 Exception: $e');
      print('🔴 StackTrace: $stackTrace');
      emit(
        state.copyWith(mess: e.toString(), createVitalStatus: ApiStatus.error),
      );
    }
  }






  
  void _onUpdateHealthProfileEvent(
    OnUpdateHealthProfileEvent event,
    Emitter<HealthProfileState> emit,
  ) async {
    emit(state.copyWith(updateProfileStatus: ApiStatus.loading));
    print('🟡 Status: Loading create vitals');
    var d = {
    "heightCm":event.heightCm,
    "bloodGroup": event.bloodGroup,
    "gender": event.gender,
    "dateOfBirth": event.dateOfBirth
};
    try {
   

      final res = await repo.createOrUpdateHealthProfile(d);
      ApiResponseHandler.handle(
        emit: emit,
        state: state,
        response: res,
        parser: (d) {
          print('🔵 Parsing data: $d');

          return d;
        },
        onSuccess: (state, mess, data) {
          log('🟢 Success: ${data.toString()} records foundv from create vatals');

          return state.copyWith(
            mess: mess,
            updateProfileStatus: ApiStatus.success,
          );
        },
        onError: (state, mess) {
          print('🔴 Error: $mess');
          return state.copyWith(updateProfileStatus: ApiStatus.error, mess: mess);
        },
      );
    } catch (e, stackTrace) {
      print('🔴 Exception: $e');
      print('🔴 StackTrace: $stackTrace');
      emit(
        state.copyWith(mess: e.toString(), updateProfileStatus: ApiStatus.error),
      );
    }
  }



}
