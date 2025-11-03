class Result {
  final Map<String, dynamic>? data;
  final int? statusCode;

  const Result({this.data, this.statusCode});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(data: json['data'], statusCode: json['statusCode'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'statusCode': statusCode};
  }
}
