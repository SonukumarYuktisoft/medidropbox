import 'package:medidropbox/app/models/bookings/myboookings_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class AppointmentState extends Equatable {
  final ApiStatus bookingStatus;
  final List<MyBookings>? bookingData;
  final String mess;
  final ApiStatus bookingDetailsStatus;
  final MyBookings? bookingDetails;
  final ApiStatus shareBookingStatus;


  const AppointmentState({
    this.bookingStatus = ApiStatus.initial,
    this.bookingData,
    this.mess='',
    this.bookingDetails,
    this.bookingDetailsStatus = ApiStatus.initial,
    this.shareBookingStatus = ApiStatus.initial,
  });

  AppointmentState copyWith({
    ApiStatus? bookingStatus,
    List<MyBookings>? bookingData,
    String? mess,
    ApiStatus? bookingDetailsStatus,
    MyBookings? bookingDetails,
     ApiStatus? shareBookingStatus
  }) {
    return AppointmentState(
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingData: bookingData ?? this.bookingData,
      mess: mess ?? this.mess,

      bookingDetailsStatus: bookingDetailsStatus ?? this.bookingDetailsStatus,
      bookingDetails: bookingDetails ?? this.bookingDetails,
      shareBookingStatus: shareBookingStatus ?? this.shareBookingStatus,
    );
  }

  @override
  List<Object?> get props => [bookingStatus, bookingData, 
  mess,bookingDetails,bookingDetailsStatus,shareBookingStatus];
}
