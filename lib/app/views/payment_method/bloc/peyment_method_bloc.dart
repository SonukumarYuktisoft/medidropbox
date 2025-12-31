
import 'package:intl/intl.dart';
import 'package:medidropbox/app/repository/appointment/appointment_repo.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
part 'peyment_method_event.dart';
part 'peyment_method_state.dart';

class PeymentMethodBloc extends Bloc<PeymentMethodEvent, PeymentMethodState> {
  AppointmentRepo repo;
  PeymentMethodBloc(this.repo) : super(PeymentMethodState()) {
    on<OnCreateBooking>(_createBooking);
  }
String getBookingDate() {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
}

String getBookingTime() {
  return DateFormat('HH:mm:ss').format(DateTime.now());
}
  void _createBooking(OnCreateBooking event, Emitter<PeymentMethodState>emit)async{
    emit(state.copyWith(createBookingStatus: ApiStatus.loading));
  try{
    var d = {
    "doctorId": event.docId,
    "hospitalId": event.hosId,
    "bookingDate": getBookingDate(),
    "bookingTime":getBookingTime(),
    "dataConsent": true,
    "payment": {
        "paymentMode": "UPI",
        "totalBill": event.totalAmount,
        "totalAmount": event.totalAmount,
        "discount": 0.00,
        "taxableAmount": event.taxableAmount,
        "gst": event.gst,
        "transactionId": "TXN1234567890UPI"
    }
    };
    final res = await repo.createAppointment(d);
    ApiResponseHandler.handle(emit: emit, state: state, response: res,
     parser: (d)=>d, onSuccess:(state,mess,data)=>state.copyWith(
      createBookingStatus: ApiStatus.success,
      mess: mess,
      data: data
     ),
      onError: (state,mess)=>state.copyWith(
        createBookingStatus: ApiStatus.error,mess: mess
      ));
  }catch(e){
     emit(state.copyWith(createBookingStatus: ApiStatus.error,mess: e.toString()));
  }

  }
}
