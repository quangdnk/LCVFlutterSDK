import 'package:LCVFlutterSDK/core/config/sdk_session.dart';
import 'package:LCVFlutterSDK/core/network/api_client.dart';
import 'package:LCVFlutterSDK/core/network/result.dart';

class CarFinderService {
  final ApiClient _client;
  final vin = SdkSession.shared.vinId;

  CarFinderService._internal(this._client);

  static CarFinderService? _instance;

  factory CarFinderService(ApiClient client) {
    _instance ??= CarFinderService._internal(client);
    return _instance!;
  }

  Future<SDKResult> carFinderByLight() async {
    return await _client.post("/rctl/car-finder-light-request/$vin");
  }

  Future<SDKResult> carFinderBySound() async {
    return await _client.post("/rctl/car-finder-sound-request/$vin");
  }
}
