import 'package:logger/logger.dart' as pkg_logger;

/// Wrapper logger SDK
class SdkLogger {
  final bool enabled;
  final pkg_logger.Logger _logger;

  SdkLogger({this.enabled = false}) : _logger = pkg_logger.Logger();

  void d(String message) {
    if (!enabled) return;
    _logger.d(message);
  }

  void i(String message) {
    if (!enabled) return;
    _logger.i(message);
  }

  void w(String message) {
    if (!enabled) return;
    _logger.w(message);
  }

  void e(String message, [dynamic error, StackTrace? st]) {
    if (!enabled) return;
    _logger.e(message, error: error, stackTrace: st);
  }
}
