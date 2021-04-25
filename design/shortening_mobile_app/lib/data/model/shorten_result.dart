
import 'package:flutter/material.dart';

class ShortCodeResult {
  bool isOk;
  String error;
  int errorCode;
  Map<String, dynamic> result;

  ShortCodeResult(
      {@required this.isOk, this.result, this.error, this.errorCode});

  factory ShortCodeResult.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson.toString());
    if (parsedJson['ok']) {
      return ShortCodeResult(
        isOk: true,
        result: parsedJson['result'],
      );
    } else {
      return ShortCodeResult(
          isOk: false,
          error: parsedJson['error'],
          errorCode: parsedJson['error_code']);
    }
  }
}
