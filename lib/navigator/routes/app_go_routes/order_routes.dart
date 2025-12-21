import 'package:go_router/go_router.dart';
import 'package:medidropbox/app/views/booking_confirmation/booking_confirmation_view.dart';
import 'package:medidropbox/app/views/payment_method/payment_method_view.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';


class OrderRoutes {
 static List<RouteBase> route =[
   GoRoute(
        path: AppRoutesPath.paymentMethod,
        name: AppRoutesName.paymentMethodView,
        builder: (context, state) => const PaymentMethodView(),
      ),

       GoRoute(
        path: AppRoutesPath.bookingConfirm,
        name: AppRoutesName.bookingConfirmView,
        builder: (context, state) => const BookingConfirmationView(),
      ),
/* 
       GoRoute(
        path: AppRoutesPath.paymentSuccess,
        name: AppRoutesName.paymentSuccessView,
        builder: (context, state) => const PaymentSuccessView(),
      ), */
    
  ];
}