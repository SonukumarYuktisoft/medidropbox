import 'package:flutter/material.dart';
import 'package:medidropbox/app/models/doctors_models/doctor_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorBookingDialog {
  static void show(BuildContext context, DoctorDetailModel doctor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'Book Appointment'.toHeadingText(
                fontSize: 20,
                appFontStyle: AppFontStyle.bold,
              ),
              16.heightBox,
              'Consultation Fee: ₹${doctor.fees?.toStringAsFixed(0) ?? '0'}'
                  .toHeadingText(
                fontSize: 16,
              ),
              24.heightBox,
              Row(
                children: [
                  if (doctor.allowRemote == true)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // TODO: Implement remote booking
                        },
                        icon: const Icon(Icons.videocam),
                        label: const Text('Remote'),
                      ),
                    ),
                  if (doctor.allowRemote == true) 16.widthBox,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement in-person booking
                      },
                      icon: const Icon(Icons.location_on),
                      label: const Text('In-person'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}