import 'package:LCVFlutterSDK/core/config/sdk_session.dart';
import 'package:LCVFlutterSDK/core/models/remote_door_sdk_request.dart';
import 'package:LCVFlutterSDK/core/models/remote_hazard_sdk_request.dart';
import 'package:LCVFlutterSDK/core/models/remote_headlight_sdk_request.dart';
import 'package:LCVFlutterSDK/core/models/remote_window_sdk_request.dart';
import 'package:LCVFlutterSDK/core/network/api_client.dart';
import 'package:LCVFlutterSDK/core/network/result.dart';

class RemoteService {
  final ApiClient _client;
  final vin = SdkSession.shared.vinId;

  RemoteService._internal(this._client);

  static RemoteService? _instance;

  factory RemoteService(ApiClient client) {
    _instance ??= RemoteService._internal(client);
    return _instance!;
  }

  Future<SDKResult> remoteDoorLock(RemoteDoorSdkRequest param) async {
    return await _client.post(
      "/rctl/remote-door-lock-request/$vin",
      queryParameters: param,
    );
  }

  Future<SDKResult> remoteWindow(RemoteWindowSdkRequest param) async {
    return await _client.post(
      "/rctl/remote-window-request/$vin",
      queryParameters: param,
    );
  }

  Future<SDKResult> remoteHazard(RemoteHazardSdkRequest param) async {
    return await _client.post(
      "/rctl/remote-hazard-request/$vin",
      queryParameters: param,
    );
  }

  Future<SDKResult> remoteHeadlight(RemoteHeadlightSdkRequest param) async {
    return await _client.post(
      "/rctl/remote-head-light-request/$vin",
      queryParameters: param,
    );
  }
}
