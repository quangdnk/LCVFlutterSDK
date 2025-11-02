import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class ReservationSeatSetting extends SdkModelRequest {
  final String frontDSeat;
  final String frontPSeat;
  final String rearDSeat;
  final String rearPSeat;

  ReservationSeatSetting({
    required this.frontDSeat,
    required this.frontPSeat,
    required this.rearDSeat,
    required this.rearPSeat,
  });

  @override
  Map<String, dynamic> toDomain() {
    return {
      frontDSeat: frontDSeat,
      frontPSeat: frontPSeat,
      rearDSeat: rearDSeat,
      rearPSeat: rearPSeat,
    };
  }
}
