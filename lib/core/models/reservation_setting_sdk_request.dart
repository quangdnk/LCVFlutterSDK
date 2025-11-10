import 'package:LCVFlutterSDK/core/config/sdk_session.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class ReservationSettingSdkRequest extends SdkModelRequest {
  final String temperature;
  final bool steering;
  final bool frontDefogger;
  final bool rearDefogger;
  final bool shVlType;

  ReservationSettingSdkRequest({
    required this.temperature,
    required this.steering,
    required this.frontDefogger,
    required this.rearDefogger,
    required this.shVlType,
  });

  @override
  Map<String, dynamic> toDomain() {
    SdkSession.shared.token = "";
    return {
      "Temperature": temperature,
      "Steering": steering,
      "FrontDefogger": steering,
      "RearDefogger": rearDefogger,
      "ShVlType": shVlType,
    };
  }
}
