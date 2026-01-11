
import 'package:medidropbox/app/models/doctors_models/all_doctors_model.dart';
import 'package:medidropbox/app/repository/doctors/doctor_repo.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

part 'doctor_tab_event.dart';
part 'doctor_tab_state.dart';

class DoctorTabBloc extends Bloc<DoctorTabEvent, DoctorTabState> {
  DoctorRepo repo;
  DoctorTabBloc(this.repo) : super(const DoctorTabState()) {

    on<OnChangedSearch>(_onChangedSearch);
    on<OnChangedSpecialty>(_onChangedSpecialty);
    on<OnChangedMinRating>(_onChangedMinRating);
    on<OnChangedMaxRating>(_onChangedMaxRating);
    on<OnChangedMinFess>(_onChangedMinFees);
    on<OnChangedMaxFess>(_onChangedMaxFees);
    on<OnChangedAllowRemote>(_onChangedAllowRemote);
    on<OnChangedIsActive>(_onChangedIsActive);

    on<OnApplyFilters>(_onApplyFilters);
    on<OnGetAllDoctors>(_onGetAllDoctorWithFillterNoAuth);
    on<OnRefressh>(_onRefresh);
    on<OnPageNation>(_onPageNation);
  }

int size = 1;
List<AllDoctorsModel>doctorList = [];
  /// 🔍 Search
  void _onChangedSearch(
      OnChangedSearch event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(search: event.search));
  }

  /// 🩺 Specialty
  void _onChangedSpecialty(
      OnChangedSpecialty event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(specialty: event.specialty));
  }

  /// ⭐ Min Rating
  void _onChangedMinRating(
      OnChangedMinRating event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(minRating: event.minRating));
  }

  /// ⭐ Max Rating
  void _onChangedMaxRating(
      OnChangedMaxRating event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(maxRating: event.maxRating));
  }

  /// 💰 Min Fees
  void _onChangedMinFees(
      OnChangedMinFess event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(minFees: event.minFees));
  }

  /// 💰 Max Fees
  void _onChangedMaxFees(
      OnChangedMaxFess event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(maxFees: event.maxFees));
  }


  /// 🖥 Remote Consultation
  void _onChangedAllowRemote(
      OnChangedAllowRemote event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(allowRemote: event.allowRemote));
  }

  /// ✅ Active / Inactive
  void _onChangedIsActive(
      OnChangedIsActive event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(isActive: event.isActive));
  }



  void _onGetAllDoctorWithFillterNoAuth(OnGetAllDoctors event, Emitter<DoctorTabState> emit) async {
    try {
     
        final params = {
          "specialty": state.specialty,
          "minRating": state.minRating,
          "maxRating": state.maxRating,
          "isActive": state.isActive,
          "minFees": state.minFees,
          "maxFees": state.maxFees,
          "allowRemote": state.allowRemote,
          "search": state.search,
          "page":"10",
          "size":size.toString()
        };

     params.removeWhere((key, value) => value == '');

      final res = await repo.getAllDoctorsWithFiltterNoAuth(params);
      ApiResponseHandler.handle<List<AllDoctorsModel>, DoctorTabState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) => (d as List).map((e) => AllDoctorsModel.fromJson(e as Map<String, dynamic>)).toList(),
        onSuccess: (state, mess, data){
          doctorList.addAll(data);
          return state.copyWith(
          mess: mess,
          doctorList: doctorList,
          doctorStatus: ApiStatus.success,
          pageStatus: ApiStatus.success,
        );
        },
        onError: (state, mess) =>
            state.copyWith( mess: mess,
              doctorStatus: ApiStatus.success,
             pageStatus: ApiStatus.error,
            ),
      );
    } catch (e) {
      emit(
        state.copyWith(mess: e.toString(),  doctorStatus: ApiStatus.error,
          pageStatus: ApiStatus.error,),
      );
    }
  }

  void _onApplyFilters(
    OnApplyFilters event,
    Emitter<DoctorTabState> emit,
  ) {
    emit(state.copyWith(doctorStatus: ApiStatus.loading));
    doctorList.clear();
    size=1;
    add(OnGetAllDoctors());
  }

  void _onPageNation(
    OnPageNation event,
    Emitter<DoctorTabState> emit,
  ) {
    emit(state.copyWith(pageStatus: ApiStatus.loading));
    size+=1;
    add(OnGetAllDoctors());
  }
  void _onRefresh(OnRefressh event, Emitter<DoctorTabState> emit) {
    emit(state.copyWith(doctorStatus: ApiStatus.loading,
    maxFees: "",minFees: "",maxRating: "",
   minRating: "",search: "",
   allowRemote: '',
   isActive: false,
   specialty: ''
    
    ));
    doctorList.clear();
    size=1;
    add(OnGetAllDoctors());
  }
}
