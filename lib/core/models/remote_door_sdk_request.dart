import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';
import 'package:LCVFlutterSDK/sdk_api.dart';

class RemoteDoorSdkRequest extends SdkModelRequest {
  final String status;
  final String security;
  final String doorId;

  RemoteDoorSdkRequest({
    required this.status,
    required this.security,
    required this.doorId,
  });

  @override
  Map<String, dynamic> toDomain() {
    return {
      "Status": status,
      "Security": security,
      "DoorId": doorId,
      "MemberId": SdkSession.shared.userId,
    };
  }
}
