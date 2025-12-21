import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class BookAppointmentBtn extends StatelessWidget {
  const BookAppointmentBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.calendar_today, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                "Book Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ).asElevatedButton(onPressed: (){
            AppNavigators.pushNamed(AppRoutesName.bookAppointmentView);
          }).paddingAll(10);
  }
}