import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
   static const String _isLoggedInKey = 'isLoggedIn';
   static const String _userToken = 'token';
   static const String _refreshToken = 'refreshToken';
   static const String _userIdKey = 'userId';
   static const String _userNameKey = 'userName';
   static const String _userEmailKey = 'userEmail';
   static const String _userPhoneKey = 'userPhone';
   static const String _userAddressKey = 'userAddress';
   static const String _userImageKey = 'userImage';


   static Future<void> setIsLoggedIn(bool isLoggedIn)async{
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    await prefe.setBool(_isLoggedInKey,isLoggedIn);
   }
   static Future<bool> getIsLoggedIn() async{
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    return prefe.getBool(_isLoggedInKey)??false;
   }

  static Future<void> setUserToken(String token)async{
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    await prefe.setString(_userToken, token);
  }
  static Future<String?> getUserToken()async{
    SharedPreferences prefe =await SharedPreferences.getInstance();
    return prefe.getString(_userToken);
  }

   static Future<void> setRefreshToken(String token)async{
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    await prefe.setString(_refreshToken, token);
  }
  static Future<String?> getRefreshToken()async{
    SharedPreferences prefe =await SharedPreferences.getInstance();
    return prefe.getString(_refreshToken);
  }
}