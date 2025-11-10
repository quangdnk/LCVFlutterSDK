import 'package:flutter/material.dart';

class SDKResult {
  final Map<String, dynamic>? data;
  final int? statusCode;

  const SDKResult({this.data, this.statusCode});

  factory SDKResult.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return SDKResult(
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'statusCode': statusCode};
  }
}
