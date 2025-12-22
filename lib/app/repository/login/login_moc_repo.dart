import 'package:medidropbox/app/data/network/api_response_model.dart';
import 'package:medidropbox/app/data/network/mock_response_handler.dart';
import 'package:medidropbox/app/repository/login/login_repo.dart';

class LoginMockApiRepository extends BaseMockRepository implements LoginRepo {
  @override
  Future<ApiResponse> loginApi(dynamic data) async {
    return mockResponse(status: true, message: 'message', data: mockResponseLo);
  }
}

@pragma('vm:entry-point')
var mockResponseLo = {
  "status": true,
  "message": "Welcome",
  "data": [
    {
      "tbl_dealer_id": "2",
      "full_name": "Sakamoto",
      "mobile": "9506045578",
      "mobile_verified": "1",
      "email": "",
      "area_pincode": 201301,
      "address": "",
      "city": "",
      "state": "",
      "country": "India",
      "dealer_image":
          "http://13.204.136.194:5001/files/upload/dealer_image/default.png",
      "kyc_status": "0",
      "verify_by_admin": "0",
      "firebase_tokens": "dgjshgjsdhfsdfdsfsd",
      "jwt_token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIiLCJpYXQiOjE3NTYxMjA1Mzl9.hrXSpoUkEItEuIDCSNWf5D-Gd_udv41yLwtMIGDgNzI",
    },
  ],
};
