import 'dart:async';
import 'package:dio/dio.dart';
import '../../constants/http_constants.dart';

typedef TokenProvider = FutureOr<String?> Function();

/// Interceptor gắn Bearer token.
/// tokenProvider có thể sync hoặc async.
class AuthInterceptor extends Interceptor {
  final TokenProvider tokenProvider;
  String? _cachedToken;

  AuthInterceptor({required this.tokenProvider, String? initialToken}) {
    _cachedToken = initialToken;
  }

  /// Cập nhật token thủ công (ví dụ sau refresh)
  void updateToken(String? token) {
    _cachedToken = token;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = _cachedToken ?? await tokenProvider();
      if (token != null && token.isNotEmpty) {
        options.headers[HttpConstants.authHeader] = 'Bearer $token';
      }
    } catch (_) {
      // Nếu provider lỗi, không block request — caller sẽ nhận mạng lỗi hoặc 401
    }
    super.onRequest(options, handler);
  }
}
