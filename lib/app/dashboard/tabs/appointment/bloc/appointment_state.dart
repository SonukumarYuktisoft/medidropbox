import 'package:medidropbox/app/models/bookings/myboookings_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class AppointmentState extends Equatable {
  final ApiStatus bookingStatus;
  final List<MyBookings>? bookingData;
  final String? mess;

  const AppointmentState({
    this.bookingStatus = ApiStatus.initial,
    this.bookingData,
    this.mess,
  });

  AppointmentState copyWith({
    ApiStatus? bookingStatus,
    List<MyBookings>? bookingData,
    String? mess,
  }) {
    return AppointmentState(
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingData: bookingData ?? this.bookingData,
      mess: mess ?? this.mess,
    );
  }

  @override
  List<Object?> get props => [bookingStatus, bookingData, mess];
}
