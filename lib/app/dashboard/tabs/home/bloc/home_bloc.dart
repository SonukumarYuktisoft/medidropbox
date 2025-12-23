
import 'package:medidropbox/app/models/hospitals/all_hospital_model.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HospitalRepo repo;
  HomeBloc(this.repo) : super(HomeState()) {
    on<OnGetAllHospital>(_onGetAllHospital);
  }
List<AllHospitalModel> allHospitalModelListFromJson(List<dynamic> json) {
  return json.map((e) => AllHospitalModel.fromJson(e as Map<String, dynamic>)).toList();
}

  void _onGetAllHospital(OnGetAllHospital event,Emitter<HomeState>emit)async{
    emit(state.copyWith(allHospitalSatatus: ApiStatus.loading));
   try{
    final res = await repo.getAllHospitals();
    ApiResponseHandler.handle<List<AllHospitalModel>,HomeState>(
      emit: emit, state: state, 
      response: res, 
      parser:(d)=> allHospitalModelListFromJson(d), 
      onSuccess: (state,mess,data)=>state.copyWith(
        allHospitalSatatus: ApiStatus.success,
        mess: mess,
        allHospitalList: data
      ),
       onError: (state,mess)=>state.copyWith(
        allHospitalSatatus: ApiStatus.error,
        mess: mess,
   
      ));
   }catch(e){
    emit(state.copyWith(mess: e.toString(),allHospitalSatatus: ApiStatus.error));
   }
  }
}
