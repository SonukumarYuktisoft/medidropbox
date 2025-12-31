import 'package:go_router/go_router.dart';
import 'package:medidropbox/app/models/common_model/book_appointment_model.dart';
import 'package:medidropbox/app/views/booking_confirmation/booking_confirmation_view.dart';
import 'package:medidropbox/app/views/payment_method/payment_method_view.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';


class OrderRoutes {
 static List<RouteBase> route =[
   GoRoute(
        path: AppRoutesPath.paymentMethod,
        name: AppRoutesName.paymentMethodView,
        builder: (context, state){
          final data = state.extra as Map<String, dynamic>;
            final model = BookAppointmentModel.fromJson(data);
          return PaymentMethodView(model);
        },
      ),

       GoRoute(
        path: AppRoutesPath.bookingConfirm,
        name: AppRoutesName.bookingConfirmView,
        builder: (context, state){
          var arg = state.extra as dynamic;
         return  BookingConfirmationView(arg);
        },
      ),
/* 
       GoRoute(
        path: AppRoutesPath.paymentSuccess,
        name: AppRoutesName.paymentSuccessView,
        builder: (context, state) => const PaymentSuccessView(),
      ), */
    
  ];
}