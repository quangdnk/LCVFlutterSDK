import 'package:LCVFlutterSDK/core/models/common/sdk_model_common.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class RemoteDoorSdkRequest extends SdkModelRequest {
  final DoorStatusSdk _status;

  RemoteDoorSdkRequest({required status}) : _status = status;

  @override
  Map<String, dynamic> toDomain() {
    return {"Status": _status.title()};
  }
}
