import 'package:flutter/material.dart';

class Result {
  final Map<String, dynamic>? data;
  final int? statusCode;

  const Result({this.data, this.statusCode});

  factory Result.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return Result(
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'statusCode': statusCode};
  }
}
