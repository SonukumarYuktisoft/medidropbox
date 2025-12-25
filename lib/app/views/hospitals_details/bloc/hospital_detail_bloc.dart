import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hospital_detail_event.dart';
part 'hospital_detail_state.dart';

class HospitalDetailBloc extends Bloc<HospitalDetailEvent, HospitalDetailState> {
  HospitalDetailBloc() : super(HospitalDetailInitial()) {
    on<HospitalDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
