import 'package:medidropbox/app/repository/profile/profile_repo.dart';
import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/app/services/mock_response_handler.dart';

class ProfileMocRepo extends BaseMockRepository implements ProfileRepo {
  @override
  Future<ApiModel> getProfile() {
    return mockResponse(status: true, message: 'message', data: _profileMoc);
  }

  @override
  Future<ApiModel> updateProfile(Map<String, dynamic> data) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}

var _profileMoc = {
  "id": 1,
  "fullName": "John Doe",
  "phone": "+91-9876543210",
  "email": "john.doe@example.com",
  "profileImageUrl": "https://example.com/profile.jpg",
  "aadharId": "123456789012",
  "abhaId": "ABHA123456789",
  "address": {
    "id": 9,
    "addressLine1": "123 Main Street",
    "addressLine2": "Apartment 4B",
    "city": "Mumbai",
    "state": "Maharashtra",
    "country": "India",
    "pincode": "400001",
    "latitude": 19.076,
    "longitude": 72.8777,
    "locationUrl": "https://maps.google.com/?q=19.0760,72.8777",
  },
  "emergencyContacts": [
    {
      "id": 1,
      "personName": "Jane Doe",
      "phone": "+91-9876543211",
      "relationship": "Spouse",
      "email": "jane.doe@example.com",
      "isPrimary": true,
      "isActive": true,
      "createdAt": "2025-12-20T11:43:36",
      "updatedAt": "2025-12-20T11:43:36",
    },
    {
      "id": 2,
      "personName": "John Doe Sr.",
      "phone": "+91-9876543212",
      "relationship": "Father",
      "email": null,
      "isPrimary": false,
      "isActive": true,
      "createdAt": "2025-12-20T11:43:36",
      "updatedAt": "2025-12-20T11:43:36",
    },
  ],
  "isActive": true,
  "createdAt": "2025-12-20T11:43:36",
  "updatedAt": "2025-12-20T11:43:36",
};
