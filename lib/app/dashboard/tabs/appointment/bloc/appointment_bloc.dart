import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_state.dart';
import 'package:medidropbox/app/models/bookings/myboookings_model.dart';
import 'package:medidropbox/app/repository/appointment/appointment_repo.dart';
import 'package:medidropbox/app/services/api_response_handler.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';

part 'appointment_event.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepo repo;

  AppointmentBloc(this.repo) : super(const AppointmentState()) {
    on<OnGetBooking>(_onBooking);
    on<OnGetBookingByid>(_onBookingDetail);
  }

  Future<void> _onBooking(
    OnGetBooking event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(bookingStatus: ApiStatus.loading));

    try {
      final res = await repo.getAppointment();

      ApiResponseHandler.handle<List<MyBookings>, AppointmentState>(
        emit: emit,
        state: state,
        response: res,
        parser: (data) =>
            List<MyBookings>.from(data.map((x) => MyBookings.fromJson(x))),
        onSuccess: (state, mess, data) => state.copyWith(
          bookingStatus: ApiStatus.success,
          mess: mess,
          bookingData: data,
        ),
        onError: (state, mess) =>
            state.copyWith(bookingStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(bookingStatus: ApiStatus.error, mess: e.toString()));
    }
  }

  Future<void> _onBookingDetail(
    OnGetBookingByid event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(bookingStatus: ApiStatus.loading));

    try {
      final res = await repo.getAppointmentByid(event.id);

      ApiResponseHandler.handle<List<MyBookings>, AppointmentState>(
        emit: emit,
        state: state,
        response: res,
        parser: (data) =>
            List<MyBookings>.from(data.map((x) => MyBookings.fromJson(x))),
        onSuccess: (state, mess, data) => state.copyWith(
          bookingStatus: ApiStatus.success,
          mess: mess,
          bookingData: data,
        ),
        onError: (state, mess) =>
            state.copyWith(bookingStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(bookingStatus: ApiStatus.error, mess: e.toString()));
    }
  }
}
