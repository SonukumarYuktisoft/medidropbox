import 'package:flutter/material.dart';
import 'package:medidropbox/app/models/doctors_models/doctor_detail_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorHospitalWidget extends StatelessWidget {
  final String? hospitalName;
  final Address? address;

  const DoctorHospitalWidget({
    super.key,
    this.hospitalName,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    if (hospitalName == null || hospitalName!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Hospital'.toHeadingText(
          appFontStyle: AppFontStyle.semiBold,
        ),
        10.heightBox,
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: const Icon(
                Icons.local_hospital,
                color: Colors.blue,
              ),
            ),
            title: hospitalName!.toHeadingText(
              appFontStyle: AppFontStyle.semiBold,
            ),
            subtitle: address != null
                ? _buildAddressString(address!).toHeadingText(
                    color: Colors.grey,
                    fontSize: 12,
                  )
                : null,
          ),
        ),
        24.heightBox,
      ],
    );
  }

  String _buildAddressString(Address address) {
    final parts = <String>[];

    if (address.addressLine1 != null && address.addressLine1!.isNotEmpty) {
      parts.add(address.addressLine1!);
    }
    if (address.city != null && address.city!.isNotEmpty) {
      parts.add(address.city!);
    }
    if (address.state != null && address.state!.isNotEmpty) {
      parts.add(address.state!);
    }

    return parts.isEmpty ? 'Address not available' : parts.join(', ');
  }
}