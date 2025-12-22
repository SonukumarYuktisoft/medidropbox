import 'dart:developer';

import 'package:medidropbox/app/services/api_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class ApiResponseHandler {
  static void handle<T, S>({
    required Emitter<S> emit,
    required S state,
    required ApiModel response,
    required T Function(dynamic) parser,
    required S Function(S, String, T) onSuccess,
    required S Function(S, String) onError,
  }) {
    if (response.status && response.data != null) {
      try {
        final parsedData = parser(response.data);
        emit(onSuccess(state, response.message, parsedData));
      } catch (e) {
        log('Parsing error: $e', name: 'API_RESPONSE_HANDLER');
        emit(onError(state, 'Failed to parse data'));
      }
    } else {
      emit(onError(state, response.message));
    }
  }
}
