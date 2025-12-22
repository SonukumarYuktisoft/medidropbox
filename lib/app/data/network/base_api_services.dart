abstract class BaseApiServices {
  Future<dynamic> getApi(String url, {bool useHeaders = true});
  Future<dynamic> postApi(String url, dynamic data, {bool useHeaders = true});
  Future<dynamic> putApi(String url, dynamic data, {bool useHeaders = true});
}
