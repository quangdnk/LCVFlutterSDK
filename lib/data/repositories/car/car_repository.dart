import 'package:LCVFlutterSDK/domain/entities/car.dart';

abstract class CarRepository {
  Future<Car> getCarDetail();
}
