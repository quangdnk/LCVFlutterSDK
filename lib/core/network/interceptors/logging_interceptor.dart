import 'dart:convert';
import 'package:LCVFlutterSDK/core/ultis/logger.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Wrapper logging interceptor:
/// - nếu config.enablePrettyLogger == true thì dùng PrettyDioLogger
/// - else dùng custom logger (Logger class) để in minimal info
class LoggingInterceptorProvider {
  static Interceptor create({
    required SdkLogger logger,
    required bool enablePretty,
  }) {
    if (enablePretty) {
      return PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
      );
    } else {
      return _SimpleLoggingInterceptor(logger);
    }
  }
}

class _SimpleLoggingInterceptor extends Interceptor {
  final SdkLogger logger;
  _SimpleLoggingInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d('→ ${options.method} ${options.uri}');
    logger.d('Headers: ${options.headers}');
    if (options.data != null) {
      try {
        logger.d('Body: ${jsonEncode(options.data)}');
      } catch (_) {
        logger.d('Body: ${options.data}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('← ${response.statusCode} ${response.requestOptions.uri}');
    try {
      logger.d('Response: ${jsonEncode(response.data)}');
    } catch (_) {
      logger.d('Response: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('✕ ${err.requestOptions.uri} — ${err.message}', err);
    if (err.response != null) {
      try {
        logger.e('Response: ${jsonEncode(err.response?.data)}');
      } catch (_) {
        logger.e('Response: ${err.response?.data}');
      }
    }
    super.onError(err, handler);
  }
}
