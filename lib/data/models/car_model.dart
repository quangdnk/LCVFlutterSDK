import 'package:LCVFlutterSDK/domain/entities/car.dart';

class CarModel extends Car {
  CarModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.year,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'].toString(),
      name: json['name'],
      brand: json['brand'],
      year: json['year'],
    );
  }
}
