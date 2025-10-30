import 'dart:convert';

import 'package:LCVFlutterSDK/core/config/sdk_config.dart';
import 'package:LCVFlutterSDK/core/config/sdk_session.dart';
import 'package:LCVFlutterSDK/core/models/vehicle_sdk_request.dart';
import 'package:LCVFlutterSDK/core/network/api_client.dart';
import 'package:LCVFlutterSDK/core/network/result.dart';
import 'package:flutter/services.dart';

class VehicleService {
  final IApiClient _client;
  final vin = SdkSession.shared.vinId;
  final SdkConfig _config;
  // Private constructor
  VehicleService._internal(this._client, this._config);

  static VehicleService? _instance;

  factory VehicleService(ApiClient client, SdkConfig config) {
    _instance ??= VehicleService._internal(client, config);
    return _instance!;
  }

  Future<Result> getVehicleInfo() async {
    if (_config.env == Environment.dev) {
      return _mockVehicleInfo();
    }
    return await _client.get('/api/hello');
  }

  Future<Result> doorControl(VehicleSdkRequest papram) async {
    if (_config.env == Environment.dev) {
      return _mockDoorControl();
    }
    return await _client.post("/vehicles", papram);
  }
}

extension VehicleServiceExtension on VehicleService {
  Future<Result> _mockVehicleInfo() async {
    await Future.delayed(const Duration(milliseconds: 200));

    final jsonStr = await rootBundle.loadString(
      'packages/LCVFlutterSDK/assets/mocks/vehicle_info.json',
    );
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;

    return Result.fromJson(data);
  }

  Future<Result> _mockDoorControl() async {
    await Future.delayed(const Duration(milliseconds: 200));

    final jsonStr = await rootBundle.loadString(
      'packages/LCVFlutterSDK/assets/mocks/vehicle_door.json',
    );
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;

    return Result.fromJson(data);
  }
}
