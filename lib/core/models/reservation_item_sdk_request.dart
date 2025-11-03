import 'package:LCVFlutterSDK/core/models/reservation_setting_sdk_request.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class ReservationItemSdkRequest extends SdkModelRequest {
  final int reservationNo;
  final bool activeStatus;
  final RepetitionSDK repetition;
  ReservationItemSdkRequest(
    this.repetition, {
    required this.reservationNo,
    required this.activeStatus,
  });

  @override
  Map<String, dynamic> toDomain() {
    return {
      "ReservationNo": reservationNo,
      "ActiveStatus": activeStatus,
      "Repetition": repetition.toDomain(),
    };
  }
}

class RepetitionSDK extends SdkModelRequest {
  final List<int> week;
  final int hour;
  final int min;
  final ReservationSettingSdkRequest setting;

  RepetitionSDK({
    required this.week,
    required this.hour,
    required this.min,
    required this.setting,
  });
  @override
  Map<String, dynamic> toDomain() {
    return {
      "Week": week,
      "Hours": hour,
      "Minutes": min,
      "AcSettings": setting.toDomain(),
    };
  }
}
