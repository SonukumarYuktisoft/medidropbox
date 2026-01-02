import 'dart:convert';

import 'package:medidropbox/app/models/doctors_models/all_doctors_model.dart';
import 'package:medidropbox/app/models/doctors_models/doctor_detail_model.dart';
import 'package:medidropbox/app/models/hospitals_models/all_hospital_model.dart';
import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/app/models/queue/live_queue_model.dart';
import 'package:medidropbox/app/models/queue/my_queue_model.dart';
import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/app/repository/queue/queue_api_repo.dart';
import 'package:medidropbox/app/repository/queue/queue_repo.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HospitalRepo repo;
  DoctorRepo doctorRepo;
  
  HomeBloc(this.repo, this.doctorRepo) : super(HomeState()) {
    on<OnGetAllHospital>(_onGetAllHospital);

    on<OnGetAllDoctors>(_onGetAllDoctor);
    on<OnGetDoctorById>(_onGetDoctorById);
    on<OnLoadMoreHospitals>(_onLoadMoreHospitals);
    on<OnFilterHospitals>(_onFilterHospitals);
    on<OnSearchHospitals>(_onSearchHospitals);
    on<OnResetHospitalFilters>(_onResetHospitalFilters);


    on<OnInitiateLiveQueueApi>(_onInitiateLiveQueueApi);
    on<OnInitiateMyQueueApi>(_onInitiateMyQueueApi);
  }

  // Parse response with pagination wrapper
  List<AllHospitalModel> allHospitalModelListFromJson(dynamic data) {
    // Check if data has pagination wrapper (content field)
    if (data is Map<String, dynamic> && data.containsKey('content')) {
      final response = AllHospitalResponse.fromJson(data);
      return response.content ?? [];
    }
    // Fallback to direct list parsing
    else if (data is List) {
      return data
          .map((e) => AllHospitalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  List<AllDoctorsModel> allDoctorModelListFromJson(List<dynamic> json) {
    return json
        .map((e) => AllDoctorsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void _onGetAllHospital(
    OnGetAllHospital event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      allHospitalStatus: ApiStatus.loading,
      currentPage: 0,
      hasMoreHospitals: true,
    ));
    
    try {
      final res = await repo.getAllHospitals(
        page: 0,
        size: state.pageSize,
        filters: state.hospitalFilters,
      );
      
      ApiResponseHandler.handle<List<AllHospitalModel>, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => allHospitalModelListFromJson(d),
        onSuccess: (state, mess, data) {
          // Check if we should have more data
          bool hasMore = data != null && data.length >= state.pageSize;
          
          return state.copyWith(
            mess: mess,
            allHospitalList: data,
            allHospitalStatus: ApiStatus.success,
            currentPage: 0,
            hasMoreHospitals: hasMore,
          );
        },
        onError: (state, mess) =>
            state.copyWith(allHospitalStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), allHospitalStatus: ApiStatus.error),
      );
    }
  }

  void _onLoadMoreHospitals(
    OnLoadMoreHospitals event,
    Emitter<HomeState> emit,
  ) async {
    if (!state.hasMoreHospitals || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));
    
    try {
      final nextPage = state.currentPage + 1;
      final res = await repo.getAllHospitals(
        page: nextPage,
        size: state.pageSize,
        filters: state.hospitalFilters,
      );
      
      ApiResponseHandler.handle<List<AllHospitalModel>, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => allHospitalModelListFromJson(d),
        onSuccess: (state, mess, data) {
          final updatedList = List<AllHospitalModel>.from(state.allHospitalList ?? [])
            ..addAll(data ?? []);
          
          return state.copyWith(
            mess: mess,
            allHospitalList: updatedList,
            allHospitalStatus: ApiStatus.success,
            currentPage: nextPage,
            hasMoreHospitals: data != null && data.length >= state.pageSize,
            isLoadingMore: false,
          );
        },
        onError: (state, mess) => state.copyWith(
          allHospitalStatus: ApiStatus.error,
          mess: mess,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        mess: e.toString(),
        isLoadingMore: false,
      ));
    }
  }

  void _onFilterHospitals(
    OnFilterHospitals event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      allHospitalStatus: ApiStatus.loading,
      hospitalFilters: event.filters,
      currentPage: 0,
      hasMoreHospitals: true,
    ));
    
    try {
      final res = await repo.getAllHospitals(
        page: 0,
        size: state.pageSize,
        filters: event.filters,
      );
      
      ApiResponseHandler.handle<List<AllHospitalModel>, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => allHospitalModelListFromJson(d),
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          allHospitalList: data,
          allHospitalStatus: ApiStatus.success,
          currentPage: 0,
          hasMoreHospitals: data != null && data.length >= state.pageSize,
        ),
        onError: (state, mess) =>
            state.copyWith(allHospitalStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), allHospitalStatus: ApiStatus.error),
      );
    }
  }

  void _onSearchHospitals(
    OnSearchHospitals event,
    Emitter<HomeState> emit,
  ) async {
    final updatedFilters = Map<String, dynamic>.from(state.hospitalFilters ?? {});
    updatedFilters['search'] = event.searchQuery;
    
    emit(state.copyWith(
      allHospitalStatus: ApiStatus.loading,
      hospitalFilters: updatedFilters,
      currentPage: 0,
      hasMoreHospitals: true,
    ));
    
    try {
      final res = await repo.getAllHospitals(
        page: 0,
        size: state.pageSize,
        filters: updatedFilters,
      );
      
      ApiResponseHandler.handle<List<AllHospitalModel>, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => allHospitalModelListFromJson(d),
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          allHospitalList: data,
          allHospitalStatus: ApiStatus.success,
          currentPage: 0,
          hasMoreHospitals: data != null && data.length >= state.pageSize,
        ),
        onError: (state, mess) =>
            state.copyWith(allHospitalStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), allHospitalStatus: ApiStatus.error),
      );
    }
  }

  void _onResetHospitalFilters(
    OnResetHospitalFilters event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      hospitalFilters: {},
      currentPage: 0,
    ));
    add(OnGetAllHospital());
  }

  void _onGetAllDoctor(OnGetAllDoctors event, Emitter<HomeState> emit) async {
    emit(state.copyWith(allDoctorStatus: ApiStatus.loading));
    try {
      final res = await doctorRepo.getAllDoctors(event.hospitalId);
      ApiResponseHandler.handle<List<AllDoctorsModel>, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => allDoctorModelListFromJson(d),
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          allDoctorList: data,
          allDoctorStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(allDoctorStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), allDoctorStatus: ApiStatus.error),
      );
    }
  }

  void _onGetDoctorById(OnGetDoctorById event, Emitter<HomeState> emit) async {
    emit(state.copyWith(doctorDetailStatus: ApiStatus.loading));
    try {
      final res = await doctorRepo.getDoctorById(event.doctorId);
      ApiResponseHandler.handle<DoctorDetailModel, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => DoctorDetailModel.fromJson(d),
        onSuccess: (state, mess, data) => state.copyWith(
          doctorDetail: data,
          mess: mess,
          doctorDetailStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(doctorDetailStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), doctorDetailStatus: ApiStatus.error),
      );
    }
  }


 void _onInitiateMyQueueApi(OnInitiateMyQueueApi event, Emitter<HomeState> emit) async {
    emit(state.copyWith(myQueueStatus: ApiStatus.loading));
    try {
        QueueRepo queueRepo = QueueApiRepo();
      final res = await queueRepo.getMyQueues();
      ApiResponseHandler.handle<List<MyQueueModel>, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) =>myQueueModelFromJson(jsonEncode(d)),
        onSuccess: (state, mess, data) => state.copyWith(
          myQueueList: data,
          mess: mess,
          myQueueStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(myQueueStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), myQueueStatus: ApiStatus.error),
      );
    }
  }

 void _onInitiateLiveQueueApi(OnInitiateLiveQueueApi event, Emitter<HomeState> emit) async {
    emit(state.copyWith(liveQueueStatus: ApiStatus.loading));
    try {
        QueueRepo queueRepo = QueueApiRepo();
      final res = await queueRepo.getLiveQueueDoctor(event.drId);
      ApiResponseHandler.handle<LiveQueueModel, HomeState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) =>liveQueueModelFromJson(jsonEncode(d)),
        onSuccess: (state, mess, data) => state.copyWith(
          liveQueueData: data,
          mess: mess,
          liveQueueStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(liveQueueStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(), liveQueueStatus: ApiStatus.error),
      );
    }
  }

}