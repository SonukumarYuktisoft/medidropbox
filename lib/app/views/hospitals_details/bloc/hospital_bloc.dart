import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hospital_event.dart';
part 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  HospitalBloc() : super(const HospitalState()) {
    on<ToggleHospitalDetails>(_toggleHospitalDetails);
  }

  void _toggleHospitalDetails(
    ToggleHospitalDetails event,
    Emitter<HospitalState> emit,
  ) {
    emit(state.copyWith(showMoreDetails: !state.showMoreDetails));
  }
}
