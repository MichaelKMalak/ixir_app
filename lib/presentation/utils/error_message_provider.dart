import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'string_utils.dart';

class ErrorMessageProvider {
  static Future<bool> show(dynamic exception) {
    const defaultErrorMessage = 'An Error has occurred';
    String message;

    if (exception == null) {
      message = defaultErrorMessage;
    } else if (exception is String) {
      message = exception;
    } else {
      message = exception.toString();
    }

    message = StringUtils.defaultOnEmpty(message, defaultErrorMessage);

    if (message.contains('Exception: ')) {
      message = message.replaceAll('Exception: ', '');
    }

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
