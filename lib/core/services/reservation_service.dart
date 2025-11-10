import 'package:LCVFlutterSDK/core/models/reservation_item_sdk_request.dart';
import 'package:LCVFlutterSDK/core/models/reservation_setting_sdk_request.dart';
import 'package:LCVFlutterSDK/core/network/api_client.dart';
import 'package:LCVFlutterSDK/sdk_api.dart';

class ReservationService {
  final IApiClient _client;
  final vin = SdkSession.shared.vinId;

  ReservationService._internal(this._client);

  static ReservationService? _instance;

  factory ReservationService(ApiClient client) {
    _instance ??= ReservationService._internal(client);
    return _instance!;
  }

  Future<SDKResult> getReservation() async {
    return await _client.get("/api/reservation");
  }

  Future<SDKResult> newReservation(ReservationItemSdkRequest param) async {
    return await _client.post("/api/reservation", param);
  }

  Future<SDKResult> editReservation(ReservationItemSdkRequest param) async {
    final id = param.reservationNo;
    return await _client.put("/api/reservation/$id", param);
  }

  Future<SDKResult> deleteReservation(int id) async {
    return await _client.delete("/api/reservation/$id");
  }

  /// RESERVATION SETTING
  Future<SDKResult> getResetvationSetting() async {
    return await _client.get("/api/reservation/set");
  }

  Future<SDKResult> setReservationSetting(
    ReservationSettingSdkRequest param,
  ) async {
    return await _client.put("/api/reservation/set", param);
  }
}
