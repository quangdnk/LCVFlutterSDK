import 'package:LCVFlutterSDK/core/models/common/sdk_model_common.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class RemoteHeadlightSdkRequest extends SdkModelRequest {
  final LightStatusSdk _status;

  RemoteHeadlightSdkRequest({required LightStatusSdk status})
    : _status = status;

  @override
  Map<String, dynamic> toDomain() {
    return {"Status": _status.title()};
  }
}
