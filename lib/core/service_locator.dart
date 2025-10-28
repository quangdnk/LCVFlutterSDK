import 'package:LCVFlutterSDK/core/config/sdk_config.dart';
import 'package:LCVFlutterSDK/core/network/api_client.dart';
import 'package:LCVFlutterSDK/core/services/vehicle_service.dart';

class ServiceLocator {
  static late final SdkConfig config;
  static late final ApiClient apiClient;
  static late final VehicleService vehicleService;

  static void setup({required SdkConfig sdkConfig}) {
    config = sdkConfig;

    // Singleton
    apiClient = ApiClient(config);
    vehicleService = VehicleService(apiClient, config);
  }
}
