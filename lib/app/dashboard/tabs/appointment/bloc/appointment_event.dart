part of 'appointment_bloc.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class OnGetBooking extends AppointmentEvent {}

class OnGetBookingByid extends AppointmentEvent {
  const OnGetBookingByid(this.id);
  final String id;
  @override
  List<Object> get props => [id];
}
