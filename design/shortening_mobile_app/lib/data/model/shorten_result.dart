import 'dart:convert';

import 'package:flutter/material.dart';

class ShortenResult {
  bool isOk;
  String error;
  int errorCode;
  Map<String, dynamic> result;

  ShortenResult({@required this.isOk, this.result, this.error, this.errorCode});

  factory ShortenResult.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson.toString());
    if (parsedJson['ok']) {
      return ShortenResult(
        isOk: true,
        result: parsedJson['result'],
      );
    } else {
      return ShortenResult(
          isOk: false,
          error: parsedJson['error'],
          errorCode: parsedJson['error_code']);
    }
  }
}
