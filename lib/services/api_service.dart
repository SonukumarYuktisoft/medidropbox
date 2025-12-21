import 'dart:convert';
import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/services/shared_preferences_helper.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response?> requestGetForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
  }) async {
    log("gteAuthToken = $authToken");
    log("getRequest url = $url");
    log("getRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      AppSnackbar.showWarning("No Internet Connection");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }
    try {
      final response = await _dio.get(
        url,
        queryParameters: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("getResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("getException=$e");
      log("getStacktrace=$s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestPostForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
  }) async {
    log("postAuthToken = $authToken");
    log("postRequest url = $url");
    log("postRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      AppSnackbar.showWarning( "No Internet Connection");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }
    try {
      final response = await _dio.post(
        url,
        data: dictParameter,
        options: Options(
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("postResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("postException=$e");
      log("postStacktrace=$s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestPutForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
  }) async {
    log("gteAuthToken = $authToken");
    log("getRequest url = $url");
    log("getRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      AppSnackbar.showWarning( "No Internet Connection");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }
    try {
      final response = await _dio.put(
        url,
        queryParameters: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("getResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("getException=$e");
      log("getStacktrace=$s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestPatchForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
  }) async {
    log("gteAuthToken = $authToken");
    log("getRequest url = $url");
    log("getRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      AppSnackbar.showWarning("No Internet Connection");
      log("❌ No Internet Connection");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }
    try {
      final response = await _dio.patch(
        url,
        queryParameters: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("getResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("getException=$e");
      log("getStacktrace=$s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestDeleteForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
  }) async {
    log("gteAuthToken = $authToken");
    log("getRequest url = $url");
    log("getRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      AppSnackbar.showWarning( "No Internet Connection");
      log("❌ No Internet Connection");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }
    try {
      final response = await _dio.delete(
        url,
        queryParameters: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("getResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("getException=$e");
      log("getStacktrace=$s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response> requestPosForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
  }) async {
    log("gteAuthToken = $authToken");
    log("getRequest url = $url");
    log("getRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      AppSnackbar.showWarning("No Internet Connection");
      log("❌ No Internet Connection");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }
    try {
      final response = await _dio.post(
        url,
        // queryParameters: dictParameter,
        data: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("getResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("getException=$e");
      log("getStacktrace=$s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  /// get headers
  Future<Map<String, String>> getHeader(bool authToken) async {
    if (authToken) {
      String? jwtToken = await SharedPreferencesHelper.getUserToken();
      log("header token = : $jwtToken");

      return {
        "Content-type": "application/json",
        "Authorization": "Bearer $jwtToken",
      };
    } else {
      return {"Content-type": "application/json"};
    }
  }
}
