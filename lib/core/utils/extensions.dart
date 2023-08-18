import 'package:dio/dio.dart';

extension OptionalStringExt on String? {
  String get value {
    return this ?? "";
  }
}

extension DioErrorExt on DioException {
  String get errMessage {
    var errMsg = '';
    if (response?.data != null) {
      String? message = response?.data["message"];
      String? error = response?.data["error"];
      String? statusMessage = response?.statusMessage;
      if (message.value.isNotEmpty) {
        errMsg = message.value;
      } else if (error.value.isNotEmpty) {
        errMsg = error.toString();
      } else if (this.message.value.isNotEmpty) {
        errMsg = this.message.value;
      } else {
        errMsg = statusMessage.value;
      }
    } else {
      errMsg = response?.statusMessage.value ?? "";
    }

    return errMsg;
  }
}
