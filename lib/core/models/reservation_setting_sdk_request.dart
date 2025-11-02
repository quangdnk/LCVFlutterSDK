import 'package:LCVFlutterSDK/core/models/reservation_seat_setting.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class ReservationSettingSdkRequest extends SdkModelRequest {
  // ignore: non_constant_identifier_names
  final String temperature;
  final bool steering;
  final bool frontDefogger;
  final bool rearDefogger;
  final bool shVlType;
  final ReservationSeatSetting shSettings;
  final ReservationSeatSetting vlSettings;

  ReservationSettingSdkRequest({
    required this.temperature,
    required this.steering,
    required this.frontDefogger,
    required this.rearDefogger,
    required this.shVlType,
    required this.shSettings,
    required this.vlSettings,
  });

  @override
  Map<String, dynamic> toDomain() {
    return {
      temperature: temperature,
      "steering": steering,
      "frontDefogger": steering,
      "rearDefogger": rearDefogger,
      "shVlType": shVlType,
      "shSettings": shSettings.toDomain(),
      "vlSettings": vlSettings.toDomain(),
    };
  }
}
