
import 'package:medidropbox/app/models/doctors_models/all_doctors_model.dart';
import 'package:medidropbox/app/models/hospitals_models/hospital_detail_model.dart';
import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

part 'hospital_detail_event.dart';
part 'hospital_detail_state.dart';

class HospitalDetailBloc extends Bloc<HospitalDetailEvent, HospitalDetailState> {
  HospitalRepo hRepo;
  DoctorRepo dRepo;
  HospitalDetailBloc(this.hRepo,this.dRepo) : super(HospitalDetailState()) {
    on<OnGetHospitalById>(_onGetHospitalById);
    on<OnGetAllDoctorsByHospital>(_onGetAllDoctor);
    on<OnSelectDoctor>(_onSelectDoctor);
  }


  void _onGetHospitalById(
    OnGetHospitalById event,
    Emitter<HospitalDetailState> emit,
  ) async {
    emit(state.copyWith(hospitalDetailStatus: ApiStatus.loading));
    try {
      final res = await hRepo.getHospitalById(event.id);

      print('Raw API Response: $res');

      ApiResponseHandler.handle<HospitalDetailModel, HospitalDetailState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) {
         
          return HospitalDetailModel.fromJson(d);
        },
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          hospitalDetail: data,
          hospitalDetailStatus: ApiStatus.success,
        ),
        onError: (state, mess) =>
            state.copyWith(hospitalDetailStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mess: e.toString(),
          hospitalDetailStatus: ApiStatus.error,
        ),
      );
    }
  }
 
 
 
  void _onGetAllDoctor(OnGetAllDoctorsByHospital event, Emitter<HospitalDetailState> emit) async {
    emit(state.copyWith(allDoctorStatus: ApiStatus.loading));
    try {
      final res = await dRepo.getAllDoctors(event.hospitalId);
      ApiResponseHandler.handle<List<AllDoctorsModel>, HospitalDetailState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => (d as List).map((e) => AllDoctorsModel.fromJson(e as Map<String, dynamic>)).toList(),
        onSuccess: (state, mess, data) => state.copyWith(
          mess: mess,
          allDoctorList: data,
          selectedDoctor: data.first,
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


  void _onSelectDoctor(
    OnSelectDoctor event,
    Emitter<HospitalDetailState> emit,
  )  {
   emit(state.copyWith(selectedDoctor: event.doc));
  }

}
