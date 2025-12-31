part of 'peyment_method_bloc.dart';

 class PeymentMethodState extends Equatable {
  const PeymentMethodState({
    this.mess='',
    this.createBookingStatus=ApiStatus.initial,
    this.data
  });
  final String mess;
  final ApiStatus createBookingStatus;
  final dynamic data;
   
PeymentMethodState copyWith({
  String? mess,
   ApiStatus? createBookingStatus,
   dynamic data,
})=>PeymentMethodState(
  mess: mess??this.mess,
  data: data??this.data,
  createBookingStatus: createBookingStatus??this.createBookingStatus
);
  @override
  List<Object?> get props => [mess,data,createBookingStatus];
}

