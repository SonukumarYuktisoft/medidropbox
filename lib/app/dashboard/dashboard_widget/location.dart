import 'dart:developer';

import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;

      return [
        p.subLocality,
        p.locality,
        p.administrativeArea,
        p.country,
      ].where((e) => e != null && e.isNotEmpty).join(", ");
    }
  } catch (e) {
    log("Geocoding error: $e");
  }
  return "";
}
