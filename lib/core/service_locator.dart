import 'package:LCVFlutterSDK/core/config/sdk_config.dart';
import 'package:LCVFlutterSDK/core/network/api_client.dart';
import 'package:LCVFlutterSDK/core/services/remote_service.dart';
import 'package:LCVFlutterSDK/core/services/reservation_service.dart';
import 'package:LCVFlutterSDK/core/services/vehicle_service.dart';

class ServiceLocator {
  static late final SdkConfig _config;
  static late final ApiClient _apiClient;
  static late final VehicleService vehicleService;
  static late final ReservationService reservationService;
  static late final RemoteService remoteService;

  static void setup({required SdkConfig sdkConfig}) {
    _config = sdkConfig;

    // Singleton
    _apiClient = ApiClient(_config);
    vehicleService = VehicleService(_apiClient, _config);
    reservationService = ReservationService(_apiClient);
    remoteService = RemoteService(_apiClient);
  }
}
