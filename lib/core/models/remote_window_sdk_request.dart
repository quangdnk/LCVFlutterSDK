import 'package:LCVFlutterSDK/core/models/common/sdk_model_common.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';

class RemoteWindowSdkRequest extends SdkModelRequest {
  final WindowStatusSdk _status;
  final WindownPositionSdk _windownPosition;

  RemoteWindowSdkRequest({
    required WindowStatusSdk status,
    required WindownPositionSdk windownPosition,
  }) : _status = status,
       _windownPosition = windownPosition;
  @override
  Map<String, dynamic> toDomain() {
    return {
      "Status": _status.title(),
      "WindowPosition": _windownPosition.title(),
    };
  }
}
