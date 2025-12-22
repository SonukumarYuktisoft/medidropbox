import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medidropbox/app/data/exception/app_exceptions.dart';
import 'package:medidropbox/app/data/network/api_headers.dart';
import 'package:medidropbox/app/data/network/base_api_services.dart' show BaseApiServices;

class NetworkServicesApi extends BaseApiServices {
  final Dio _dio;

  NetworkServicesApi()
    : _dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      ) {
    // ⭐ Initialize interceptors here
    _initializeInterceptors();
  }

  /// Initialize all interceptors
  void _initializeInterceptors() {
    _dio.interceptors.addAll([
      // 1. Connectivity Interceptor - Check internet before request
      // ConnectivityInterceptor(),

      // // 2. Logging Interceptor - Log requests/responses in debug mode
      // LoggingInterceptor(),

      // // 3. Retry Interceptor - Auto retry on failure
      // RetryInterceptor(dio: _dio),
    ]);
  }

  @override
  Future<dynamic> getApi(
    String url, {
    bool useHeaders = true,
    Map<String, dynamic>? header,
  }) async {
    try {
      log(url, name: 'API URL');

      Map<String, dynamic>? finalHeaders;
      if (header == null) {
        finalHeaders = useHeaders
            ? ApiHeaders.instance.getAllHeaders()
            : ApiHeaders.instance.getPublicHeaders();
      } else {
        finalHeaders = header;
      }

      ApiHeaders.instance.debugPrintHeaders();

      final response = await _dio.get(
        url,
        options: Options(headers: finalHeaders),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      log('${e.message}', name: 'DioException NETWORK ERROR');
      throw _handleDioError(e);
    } catch (e) {
      log('$e', name: 'General Exception NETWORK ERROR');
      throw FetchDataException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<dynamic> postApi(
    String url,
    dynamic data, {
    bool useHeaders = true,
    bool isUpload = false,
    bool isAuth = false,
    Map<String, dynamic>? header,
  }) async {
    try {
      log(url, name: 'API URL');
      log(data.toString(), name: 'DATA PAYLOAD');

      Map<String, dynamic>? finalHeaders;

      if (header == null) {
        if (isUpload) {
          finalHeaders = useHeaders
              ? ApiHeaders.instance.getBasicHeaders()
              : null;
        } else if (isAuth) {
          finalHeaders = useHeaders
              ? ApiHeaders.instance.getAuthHeaders()
              : null;
        } else {
          finalHeaders = useHeaders
              ? ApiHeaders.instance.getAllHeaders()
              : ApiHeaders.instance.getPublicHeaders();
        }
      } else {
        finalHeaders = header;
      }

      final response = await _dio.post(
        url,
        data: data,
        options: Options(headers: finalHeaders),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      log('${e.message}', name: 'DioException NETWORK ERROR');
      throw _handleDioError(e);
    } catch (e) {
      log('$e', name: 'General Exception NETWORK ERROR');
      throw FetchDataException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<dynamic> putApi(
    String url,
    dynamic data, {
    bool useHeaders = true,
    bool isUpload = false,
  }) async {
    try {
      log(url, name: 'API URL');
      log(data.toString(), name: 'DATA PAYLOAD');

      Map<String, dynamic>? finalHeaders;

      if (isUpload) {
        finalHeaders = useHeaders
            ? ApiHeaders.instance.getBasicHeaders()
            : null;
      } else {
        finalHeaders = useHeaders
            ? ApiHeaders.instance.getAllHeaders()
            : ApiHeaders.instance.getPublicHeaders();
      }

      final response = await _dio.put(
        url,
        data: data,
        options: Options(headers: finalHeaders),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      log('${e.message}', name: 'DioException NETWORK ERROR');
      throw _handleDioError(e);
    } catch (e) {
      log('$e', name: 'General Exception NETWORK ERROR');
      throw FetchDataException('Network error: ${e.toString()}');
    }
  }

  dynamic _handleResponse(Response response) {
    log('${response.statusCode}', name: 'Response Status Code');
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        return response.data;
      case 401:
        throw UnAuthoriseException('Unauthorized');
      case 403:
        throw UnAuthoriseException('Forbidden');
      case 404:
        throw FetchDataException('Not found');
      case 500:
      case 502:
      case 503:
        throw FetchDataException('Server error: ${response.statusCode}');
      default:
        throw FetchDataException('Unexpected error: ${response.statusCode}');
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return FetchDataException('Connection timeout');
      case DioExceptionType.badResponse:
        return FetchDataException(
          e.response!.data == null
              ? e.response?.toString()
              : (e.response!.data['message'] == null)
              ? e.response!.data.toString()
              : e.response!.data['message'].toString(),
        );
      case DioExceptionType.cancel:
        return FetchDataException('Request cancelled');
      case DioExceptionType.connectionError:
        return FetchDataException('No internet connection');
      default:
        return FetchDataException('Network error: ${e.message}');
    }
  }
}
