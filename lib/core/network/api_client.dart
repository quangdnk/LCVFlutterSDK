import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import '../config/sdk_config.dart';
import '../constants/http_constants.dart';
import '../errors/api_exception.dart';
import '../errors/network_exception.dart';
import '../ultis/logger.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

typedef JsonConverter<T> = T Function(dynamic json);

class ApiClient {
  final Dio dio;
  final SdkConfig config;
  final SdkLogger logger;
  final AuthInterceptor _authInterceptor;

  ApiClient._(this.dio, this.config, this.logger, this._authInterceptor);

  factory ApiClient({
    required SdkConfig config,
    TokenProvider? tokenProvider,
    String? initialToken,
    Map<String, dynamic>? defaultHeaders,
  }) {
    final options = BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: config.timeout,
      receiveTimeout: config.timeout,
      headers: {...HttpConstants.defaultHeaders, ...?defaultHeaders},
    );

    final dio = Dio(options);

    final logger = SdkLogger(enabled: config.enableLogging);

    final auth = AuthInterceptor(
      tokenProvider: tokenProvider ?? (() => null),
      initialToken: initialToken,
    );

    // Add interceptors: order matters (auth first? we add auth before logging so logs include auth header if present)
    dio.interceptors.add(auth);

    dio.interceptors.add(
      LoggingInterceptorProvider.create(
        logger: logger,
        enablePretty: config.enablePrettyLogger,
      ),
    );

    // Ensure each request stores reference to dio so interceptors (retry) can use it for re-send
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.extra['sdk_dio_instance'] = dio;
          return handler.next(options);
        },
      ),
    );

    return ApiClient._(dio, config, logger, auth);
  }

  /// Update token at runtime (useful after refresh)
  void updateAccessToken(String? token) => _authInterceptor.updateToken(token);

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    JsonConverter<T>? converter,
    Options? options,
  }) => _request(
    'GET',
    path,
    queryParameters: queryParameters,
    converter: converter,
    options: options,
  );

  Future<T> post<T>(
    String path, {
    dynamic data,
    JsonConverter<T>? converter,
    Options? options,
  }) => _request(
    'POST',
    path,
    data: data,
    converter: converter,
    options: options,
  );

  Future<T> put<T>(
    String path, {
    dynamic data,
    JsonConverter<T>? converter,
    Options? options,
  }) =>
      _request('PUT', path, data: data, converter: converter, options: options);

  Future<T> delete<T>(
    String path, {
    dynamic data,
    JsonConverter<T>? converter,
    Options? options,
  }) => _request(
    'DELETE',
    path,
    data: data,
    converter: converter,
    options: options,
  );

  Future<T> _request<T>(
    String method,
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    JsonConverter<T>? converter,
    Options? options,
  }) async {
    try {
      final resp = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
      );

      final payload = resp.data;
      if (converter != null) return converter(payload);
      return payload as T;
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Exception _mapDioError(DioException e) {
    // timeout & network
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Request timed out');
    }

    if (e.type == DioExceptionType.unknown ||
        e.type == DioExceptionType.badCertificate) {
      return NetworkException(e.message ?? 'Network error');
    }

    // If response exists -> ApiException
    if (e.response != null) {
      final status = e.response?.statusCode;
      final data = e.response?.data;
      String message = e.response?.statusMessage ?? 'API error';
      try {
        if (data is Map &&
            (data['message'] is String || data['error'] is String)) {
          message = (data['message'] ?? data['error']) as String;
        } else if (data is String) {
          message = data;
        }
      } catch (_) {
        // ignore parsing errors
      }
      return ApiException(message: message, statusCode: status, body: data);
    }

    // fallback
    return NetworkException(e.message ?? 'Unknown network error');
  }
}
