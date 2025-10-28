import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class VehicleSdkRequest extends SdkModelRequest {
  final String vehicleId;
  final bool includeStatus;

  VehicleSdkRequest({required this.vehicleId, this.includeStatus = true});

  @override
  Map<String, dynamic> toDomain() {
    return {"vehicleId": vehicleId, "includeStatus": includeStatus};
  }
}
