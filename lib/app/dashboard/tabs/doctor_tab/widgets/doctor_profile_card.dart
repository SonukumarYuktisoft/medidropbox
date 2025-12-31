
import 'package:flutter/material.dart';
import 'package:medidropbox/app/models/doctors_models/all_doctors_model.dart';
import 'package:medidropbox/core/extensions/image_extesion.dart';
import 'package:medidropbox/navigator/app_navigators/app_navigators.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';

class DoctorProfileCard extends StatelessWidget {
   final AllDoctorsModel doctor;

  const DoctorProfileCard( {
    super.key, required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (
      onTap: () {
         AppNavigators.pushNamed(
          AppRoutesName.doctorDetailsView,
          extra: doctor.id.toString(),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Center(child: doctor.profilePhotoUrl.toCircularImage(size: 70)),
          SizedBox(height: 10),
          Text(
            doctor.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
           Text(
            doctor.specialty,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
