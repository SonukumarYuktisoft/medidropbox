import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/dashboard_widget/hospitals_dropDown.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DashboardTopBaar extends StatelessWidget {
  const DashboardTopBaar({super.key});

  @override
  Widget build(BuildContext context) {
    List hospitals = [
      {
        "id": 1,
        "name": "City General Hospital1",
        "founder": null,
        "foundedOn": "1990-01-15",
        "images": [
          "https://example.com/hospital-image1.jpg",
          "https://example.com/hospital-image2.jpg",
        ],
        "address": {
          "id": 1,
          "addressLine1": "123 Medical Street",
          "addressLine2": "Block A",
          "city": "Mumbai",
          "state": "Maharashtra",
          "country": "India",
          "pincode": "400001",
          "latitude": 19.076,
          "longitude": 72.8777,
          "locationUrl": "https://maps.google.com/?q=19.0760,72.8777",
        },
        "socialMediaLinks": [
          {
            "id": 1,
            "platformName": "Facebook",
            "profileUrl": "https://facebook.com/cityhospital",
          },
          {
            "id": 2,
            "platformName": "Twitter",
            "profileUrl": "https://twitter.com/cityhospital",
          },
        ],
        "emergencyAvailable": true,
        "country": "India",
        "services": ["Emergency Care", "Cardiology", "Neurology", "Pediatrics"],
        "facilities": [
          "24/7 Emergency",
          "ICU",
          "Operation Theater",
          "Pharmacy",
        ],
        "emergencyCallNumber": null,
        "bookingCallNumber": null,
        "isActive": true,
        "adminUsername": null,
      },
      {
        "id": 3,
        "name": "City General Hospital2",
        "founder": null,
        "foundedOn": "1990-01-15",
        "images": [
          "https://example.com/hospital-image1.jpg",
          "https://example.com/hospital-image2.jpg",
        ],
        "address": {
          "id": 3,
          "addressLine1": "123 Medical Street",
          "addressLine2": "Block A",
          "city": "Mumbai",
          "state": "Maharashtra",
          "country": "India",
          "pincode": "400001",
          "latitude": 19.076,
          "longitude": 72.8777,
          "locationUrl": "https://maps.google.com/?q=19.0760,72.8777",
        },
        "socialMediaLinks": [
          {
            "id": 5,
            "platformName": "Facebook",
            "profileUrl": "https://facebook.com/cityhospital",
          },
          {
            "id": 6,
            "platformName": "Twitter",
            "profileUrl": "https://twitter.com/cityhospital",
          },
        ],
        "emergencyAvailable": true,
        "country": "India",
        "services": ["Emergency Care", "Cardiology", "Neurology", "Pediatrics"],
        "facilities": [
          "24/7 Emergency",
          "ICU",
          "Operation Theater",
          "Pharmacy",
        ],
        "emergencyCallNumber": null,
        "bookingCallNumber": null,
        "isActive": true,
        "adminUsername": null,
      },
      {
        "id": 11,
        "name": "City General Hospital3",
        "founder": null,
        "foundedOn": "1990-01-15",
        "images": [
          "https://example.com/hospital-image1.jpg",
          "https://example.com/hospital-image2.jpg",
        ],
        "address": {
          "id": 17,
          "addressLine1": "123 Medical Street",
          "addressLine2": "Block A",
          "city": "Mumbai",
          "state": "Maharashtra",
          "country": "India",
          "pincode": "400001",
          "latitude": 19.076,
          "longitude": 72.8777,
          "locationUrl": "https://maps.google.com/?q=19.0760,72.8777",
        },
        "socialMediaLinks": [
          {
            "id": 21,
            "platformName": "Facebook",
            "profileUrl": "https://facebook.com/cityhospital",
          },
          {
            "id": 22,
            "platformName": "Twitter",
            "profileUrl": "https://twitter.com/cityhospital",
          },
        ],
        "emergencyAvailable": true,
        "country": "India",
        "services": ["Emergency Care", "Cardiology", "Neurology", "Pediatrics"],
        "facilities": [
          "24/7 Emergency",
          "ICU",
          "Operation Theater",
          "Pharmacy",
        ],
        "emergencyCallNumber": null,
        "bookingCallNumber": null,
        "isActive": true,
        "adminUsername": null,
      },
      {
        "id": 7,
        "name": "City General Hospital Updated",
        "founder": null,
        "foundedOn": "1990-01-15",
        "images": ["https://example.com/hospital-image1.jpg"],
        "address": {
          "id": 7,
          "addressLine1": "123 Medical Street",
          "addressLine2": "Block A",
          "city": "Mumbai",
          "state": "Maharashtra",
          "country": "India",
          "pincode": "400001",
          "latitude": null,
          "longitude": null,
          "locationUrl": null,
        },
        "socialMediaLinks": [
          {
            "id": 13,
            "platformName": "Facebook",
            "profileUrl": "https://facebook.com/cityhospital",
          },
          {
            "id": 14,
            "platformName": "Twitter",
            "profileUrl": "https://twitter.com/cityhospital",
          },
        ],
        "emergencyAvailable": true,
        "country": "India",
        "services": ["Emergency Care", "Cardiology", "Neurology"],
        "facilities": ["24/7 Emergency", "ICU"],
        "emergencyCallNumber": null,
        "bookingCallNumber": null,
        "isActive": true,
        "adminUsername": null,
      },
      {
        "id": 12,
        "name": "Parveen Hospital",
        "founder": null,
        "foundedOn": "2025-06-16",
        "images": [
          "https://www.pexels.com/photo/medical-equipment-on-an-operation-room-3844581/",
        ],
        "address": {
          "id": 19,
          "addressLine1":
              "Nagar Bihta, Laee, Bihta, Danapur, Patna, Bihar-801112",
          "addressLine2": "Ward no 22",
          "city": "Patna",
          "state": "Bihar",
          "country": "India",
          "pincode": "801112",
          "latitude": null,
          "longitude": null,
          "locationUrl": "",
        },
        "socialMediaLinks": [
          {
            "id": 23,
            "platformName": "LinkedIn",
            "profileUrl": "https://www.linkedin.com/feed/",
          },
        ],
        "emergencyAvailable": true,
        "country": "India",
        "services": ["Eye Specialist"],
        "facilities": ["24/7 Emergency"],
        "emergencyCallNumber": null,
        "bookingCallNumber": null,
        "isActive": true,
        "adminUsername": null,
      },
    ];

    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) =>
          previous.tabPosition != current.tabPosition,
      builder: (context, state) {
        if (state.tabPosition == 0 || state.tabPosition == 1) {
          return SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      "Find Your".toHeadingText(
                        appFontStyle: AppFontStyle.medium,
                        color: Colors.black87,
                        fontSize: 14,
                      ),

                      "Specialist".toHeadingText(
                        appFontStyle: AppFontStyle.semiBold,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: state.tabPosition == 1
                      ? HospitalsDropdown()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              CupertinoIcons.search,
                            ).asIconButton(onPressed: () {}),

                            Icon(
                              CupertinoIcons.chat_bubble,
                            ).asIconButton(onPressed: () {}),
                          ],
                        ),
                ),
              ],
            ).paddingOnly(left: 15, right: 5),
          );
        }
        return SizedBox();
      },
    );
  }
}
