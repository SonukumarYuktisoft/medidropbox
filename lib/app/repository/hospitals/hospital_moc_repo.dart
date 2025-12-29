import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/mock_response_handler.dart';

class HospitalMocRepo extends BaseMockRepository implements HospitalRepo {
  @override
  Future<ApiModel> getAllHospitals({
    int page = 0,
    int size = 10,
    Map<String, dynamic>? filters,
  }) {
    // Simulate filtering logic
    List<dynamic> filteredData = List.from(allHospitalMoc);

    if (filters != null) {
      // Filter by state
      if (filters['state'] != null && filters['state'].toString().isNotEmpty) {
        filteredData = filteredData.where((hospital) {
          return hospital['address']['state']
              .toString()
              .toLowerCase()
              .contains(filters['state'].toString().toLowerCase());
        }).toList();
      }

      // Filter by city
      if (filters['city'] != null && filters['city'].toString().isNotEmpty) {
        filteredData = filteredData.where((hospital) {
          return hospital['address']['city']
              .toString()
              .toLowerCase()
              .contains(filters['city'].toString().toLowerCase());
        }).toList();
      }

      // Filter by pincode
      if (filters['pincode'] != null && filters['pincode'].toString().isNotEmpty) {
        filteredData = filteredData.where((hospital) {
          return hospital['address']['pincode']
              .toString()
              .contains(filters['pincode'].toString());
        }).toList();
      }

      // Filter by search
      if (filters['search'] != null && filters['search'].toString().isNotEmpty) {
        filteredData = filteredData.where((hospital) {
          return hospital['name']
              .toString()
              .toLowerCase()
              .contains(filters['search'].toString().toLowerCase());
        }).toList();
      }

      // Filter by emergencyAvailable
      if (filters['emergencyAvailable'] == true) {
        filteredData = filteredData.where((hospital) {
          return hospital['emergencyAvailable'] == true;
        }).toList();
      }

      // Filter by isActive
      if (filters['isActive'] != null) {
        filteredData = filteredData.where((hospital) {
          return hospital['isActive'] == filters['isActive'];
        }).toList();
      }

      // Filter by is24x7 (check if facilities contain "24/7")
      if (filters['is24x7'] == true) {
        filteredData = filteredData.where((hospital) {
          final facilities = hospital['facilities'] as List;
          return facilities.any((f) => f.toString().contains('24/7'));
        }).toList();
      }

      // Filter by hasAmbulance (check if services contain "Ambulance")
      if (filters['hasAmbulance'] == true) {
        filteredData = filteredData.where((hospital) {
          final services = hospital['services'] as List;
          return services.any((s) => s.toString().toLowerCase().contains('ambulance'));
        }).toList();
      }
    }

    // Simulate pagination
    final startIndex = page * size;
    final endIndex = (startIndex + size).clamp(0, filteredData.length);
    
    final paginatedData = startIndex < filteredData.length
        ? filteredData.sublist(startIndex, endIndex)
        : [];

    // Return paginated response with metadata
    final paginatedResponse = {
      "content": paginatedData,
      "page": page,
      "size": size,
      "totalElements": filteredData.length,
      "totalPages": (filteredData.length / size).ceil(),
      "first": page == 0,
      "last": endIndex >= filteredData.length,
    };

    return mockResponse(
      status: true,
      message: "success",
      data: paginatedResponse,
    );
  }

  @override
  Future<ApiModel> getHospitalById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<ApiModel> getHospitalByIdPublicNoAuth(String id) {
    throw UnimplementedError();
  }
}

var allHospitalMoc = [
  {
    "id": 1,
    "name": "City General Hospital",
    "founder": null,
    "foundedOn": "1990-01-15",
    "images": [
      "https://example.com/hospital-image1.jpg",
      "https://example.com/hospital-image2.jpg"
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
      "locationUrl": "https://maps.google.com/?q=19.0760,72.8777"
    },
    "socialMediaLinks": [
      {
        "id": 1,
        "platformName": "Facebook",
        "profileUrl": "https://facebook.com/cityhospital"
      },
      {
        "id": 2,
        "platformName": "Twitter",
        "profileUrl": "https://twitter.com/cityhospital"
      }
    ],
    "emergencyAvailable": true,
    "country": "India",
    "services": [
      "Emergency Care",
      "Cardiology",
      "Neurology",
      "Pediatrics"
    ],
    "facilities": [
      "24/7 Emergency",
      "ICU",
      "Operation Theater",
      "Pharmacy"
    ],
    "emergencyCallNumber": null,
    "bookingCallNumber": null,
    "isActive": true,
    "adminUsername": null
  },
  {
    "id": 3,
    "name": "City General Hospital",
    "founder": null,
    "foundedOn": "1990-01-15",
    "images": [
      "https://example.com/hospital-image1.jpg",
      "https://example.com/hospital-image2.jpg"
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
      "locationUrl": "https://maps.google.com/?q=19.0760,72.8777"
    },
    "socialMediaLinks": [
      {
        "id": 5,
        "platformName": "Facebook",
        "profileUrl": "https://facebook.com/cityhospital"
      },
      {
        "id": 6,
        "platformName": "Twitter",
        "profileUrl": "https://twitter.com/cityhospital"
      }
    ],
    "emergencyAvailable": true,
    "country": "India",
    "services": [
      "Emergency Care",
      "Cardiology",
      "Neurology",
      "Pediatrics"
    ],
    "facilities": [
      "24/7 Emergency",
      "ICU",
      "Operation Theater",
      "Pharmacy"
    ],
    "emergencyCallNumber": null,
    "bookingCallNumber": null,
    "isActive": true,
    "adminUsername": null
  },
  {
    "id": 11,
    "name": "City General Hospital",
    "founder": null,
    "foundedOn": "1990-01-15",
    "images": [
      "https://example.com/hospital-image1.jpg",
      "https://example.com/hospital-image2.jpg"
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
      "locationUrl": "https://maps.google.com/?q=19.0760,72.8777"
    },
    "socialMediaLinks": [
      {
        "id": 21,
        "platformName": "Facebook",
        "profileUrl": "https://facebook.com/cityhospital"
      },
      {
        "id": 22,
        "platformName": "Twitter",
        "profileUrl": "https://twitter.com/cityhospital"
      }
    ],
    "emergencyAvailable": true,
    "country": "India",
    "services": [
      "Emergency Care",
      "Cardiology",
      "Neurology",
      "Pediatrics"
    ],
    "facilities": [
      "24/7 Emergency",
      "ICU",
      "Operation Theater",
      "Pharmacy"
    ],
    "emergencyCallNumber": null,
    "bookingCallNumber": null,
    "isActive": true,
    "adminUsername": null
  },
  {
    "id": 7,
    "name": "City General Hospital Updated",
    "founder": null,
    "foundedOn": "1990-01-15",
    "images": [
      "https://example.com/hospital-image1.jpg"
    ],
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
      "locationUrl": null
    },
    "socialMediaLinks": [
      {
        "id": 13,
        "platformName": "Facebook",
        "profileUrl": "https://facebook.com/cityhospital"
      },
      {
        "id": 14,
        "platformName": "Twitter",
        "profileUrl": "https://twitter.com/cityhospital"
      }
    ],
    "emergencyAvailable": true,
    "country": "India",
    "services": [
      "Emergency Care",
      "Cardiology",
      "Neurology"
    ],
    "facilities": [
      "24/7 Emergency",
      "ICU"
    ],
    "emergencyCallNumber": null,
    "bookingCallNumber": null,
    "isActive": true,
    "adminUsername": null
  },
  {
    "id": 12,
    "name": "Parveen Hospital",
    "founder": null,
    "foundedOn": "2025-06-16",
    "images": [
      "https://www.pexels.com/photo/medical-equipment-on-an-operation-room-3844581/"
    ],
    "address": {
      "id": 19,
      "addressLine1": "Nagar Bihta, Laee, Bihta, Danapur, Patna, Bihar-801112",
      "addressLine2": "Ward no 22",
      "city": "Patna",
      "state": "Bihar",
      "country": "India",
      "pincode": "801112",
      "latitude": null,
      "longitude": null,
      "locationUrl": ""
    },
    "socialMediaLinks": [
      {
        "id": 23,
        "platformName": "LinkedIn",
        "profileUrl": "https://www.linkedin.com/feed/"
      }
    ],
    "emergencyAvailable": true,
    "country": "India",
    "services": [
      "Eye Specialist"
    ],
    "facilities": [
      "24/7 Emergency"
    ],
    "emergencyCallNumber": null,
    "bookingCallNumber": null,
    "isActive": true,
    "adminUsername": null
  }
];