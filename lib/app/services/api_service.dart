// lib/services/api_service.dart
import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medidropbox/app/services/shared_preferences_helper.dart';
import 'package:medidropbox/core/helpers/toast/toast_helper.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response?> requestGetForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
    BuildContext? context,
  }) async {
    log("gteAuthToken = $authToken");
    log("getRequest url = $url");
    log("getRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
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
    BuildContext? context,
  }) async {
    log("postAuthToken = $authToken");
    log("postRequest url = $url");
    log("postRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
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

  /// POST with FormData (for file uploads)
  Future<Response?> requestPostWithFormData({
    required String url,
    required FormData formData,
    required bool authToken,
    Function(int, int)? onSendProgress,
    BuildContext? context,
  }) async {
    log("postAuthToken = $authToken");
    log("postRequest url = $url");
    log("postRequest with FormData");
    
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
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
        data: formData,
        options: Options(
          headers: await getHeaderForFormData(authToken),
          sendTimeout: Duration(seconds: 60), // Longer timeout for file uploads
          receiveTimeout: Duration(seconds: 60),
          validateStatus: (_) => true,
        ),
        onSendProgress: onSendProgress,
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

  /// Helper method to create FormData from Map and File
  Future<FormData> createFormData({
    required Map<String, dynamic> data,
    File? imageFile,
    String imageFieldName = 'profileImage',
  }) async {
    Map<String, dynamic> formDataMap = {};

    // Add all text fields
    data.forEach((key, value) {
      if (value != null) {
        if (value is Map || value is List) {
          formDataMap[key] = jsonEncode(value);
        } else {
          formDataMap[key] = value.toString();
        }
      }
    });

    // Add image file if present
    if (imageFile != null) {
      String fileName = imageFile.path.split('/').last;
      formDataMap[imageFieldName] = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      );
    }

    return FormData.fromMap(formDataMap);
  }

  Future<Response?> requestPutForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
    BuildContext? context,
  }) async {
    log("gteAuthToken = $authToken");
    log("getRequest url = $url");
    log("getRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
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
        data: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("putResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("putException=$e");
      log("putStacktrace=$s");
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
    BuildContext? context,
  }) async {
    log("gteAuthToken = $authToken");
    log("patchRequest url = $url");
    log("patchRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
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
        data: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("patchResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("patchException=$e");
      log("patchStacktrace=$s");
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
    BuildContext? context,
  }) async {
    log("gteAuthToken = $authToken");
    log("deleteRequest url = $url");
    log("deleteRequest parameter = ${dictParameter.toString()}");
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
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
        data: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: await getHeader(authToken),
          sendTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
          validateStatus: (_) => true,
        ),
      );
      log("deleteResponse=${response.data}");
      return response;
    } catch (e, s) {
      log("deleteException=$e");
      log("deleteStacktrace=$s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  /// Get headers for JSON
  Future<Map<String, String>> getHeader(bool authToken) async {
    if (authToken) {
      String? jwtToken = await SharedPreferencesHelper.getUserToken();
      log("header accessToken = : $jwtToken");

      return {
        "Content-type": "application/json",
        "Authorization": "Bearer $jwtToken",
      };
    } else {
      return {"Content-type": "application/json"};
    }
  }

  /// Get headers for FormData
  Future<Map<String, String>> getHeaderForFormData(bool authToken) async {
    if (authToken) {
      String? jwtToken = await SharedPreferencesHelper.getUserToken();
      log("header accessToken = : $jwtToken");

      return {
        "Content-type": "multipart/form-data",
        "Authorization": "Bearer $jwtToken",
      };
    } else {
      return {"Content-type": "multipart/form-data"};
    }
  }
}