import 'package:medidropbox/app/dashboard/tabs/home/widget/available_doctors.dart'
    show AvailableDoctors;
import 'package:medidropbox/app/dashboard/tabs/home/widget/banner_card.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/hospital_card.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/my_queue_card.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: AnimatedBookButton(
      //   onPressed: () {
      //        AppSnackbar.showInfo(' Coming soon!');
      //   },
      //   fees: 'Book Now',
      // ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCard(),
            15.heightBox,
            MyQueueCard(),
            
            HospitalCard(),
            10.heightBox,
            AvailableDoctors(),
          ],
        ),
      ),
    );
  }
}
