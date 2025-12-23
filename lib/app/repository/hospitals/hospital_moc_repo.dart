import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/mock_response_handler.dart';

class HospitalMocRepo extends BaseMockRepository implements HospitalRepo {
  @override
  Future<ApiModel> getAllHospitals() {
    return mockResponse(status: true, message: "success",data: allHospitalMoc);
  }

  @override
  Future<ApiModel> getHospitalById(String id) {
    // TODO: implement getHospitalById
    throw UnimplementedError();
  }

  @override
  Future<ApiModel> getHospitalByIdPublicNoAuth(String id) {
    // TODO: implement getHospitalByIdPublicNoAuth
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
    }
];