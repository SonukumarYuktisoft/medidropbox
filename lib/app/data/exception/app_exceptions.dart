class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return '$_message$_prefix';
  }
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
    : super(message, 'No Internet Exception');
}

class UnAuthoriseException extends AppException {
  UnAuthoriseException([String? message])
    : super(message, 'You dont have access to this');
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? message])
    : super(message, 'Request Time out');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Bad Request');
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, '');
}
