import 'package:LCVFlutterSDK/core/config/sdk_config.dart';
import 'package:LCVFlutterSDK/core/config/sdk_session.dart';
import 'package:LCVFlutterSDK/core/constants/http_constants.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';
import 'package:LCVFlutterSDK/core/network/result.dart';
import 'package:dio/dio.dart';

import 'package:uuid/uuid.dart';

abstract class IApiClient {
  Future<SDKResult> get(
    String path, {
    SdkModelRequest? queryParameters,
    Options? options,
  });
  Future<SDKResult> post(
    String path, {
    SdkModelRequest? queryParameters,
    dynamic data,
    Options? options,
  });

  Future<SDKResult> put(
    String path,
    SdkModelRequest? queryParameters, {
    dynamic data,
    Options? options,
  });

  Future<SDKResult> delete(String path, {Options? options});
}

class ApiClient implements IApiClient {
  final Dio _dio;

  ApiClient(SdkConfig config)
    : _dio = Dio(
        BaseOptions(
          baseUrl: config.env.endpoint(),
          connectTimeout: config.timeout,
          receiveTimeout: config.timeout,
          headers: {...HttpConstants.defaultHeaders, ...?config.headers},
        ),
      );

  Options _buildOptions([Options? options]) {
    final token = SdkSession.shared.token;
    final headers = Map<String, dynamic>.from(options?.headers ?? {});
    headers["correlation-id"] = Uuid().v4();
    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }
    return (options ?? Options()).copyWith(headers: headers);
  }

  /// GET
  @override
  Future<SDKResult> get(
    String path, {
    SdkModelRequest? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters?.toDomain(),
        options: _buildOptions(options),
      );
      return SDKResult.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// POST
  @override
  Future<SDKResult> post(
    String path, {
    SdkModelRequest? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: queryParameters?.toDomain(),
        data: data,
        options: _buildOptions(options),
      );
      return SDKResult.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// PUT
  @override
  Future<SDKResult> put(
    String path,
    SdkModelRequest? queryParameters, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: queryParameters?.toDomain(),
        data: data,
        options: _buildOptions(options),
      );
      return SDKResult.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// DELETE
  @override
  Future<SDKResult> delete(String path, {Options? options}) async {
    try {
      final response = await _dio.delete(path, options: _buildOptions(options));
      return SDKResult.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  SDKResult _handleError(DioException e) {
    return SDKResult(
      data: {
        "error": e.message ?? "Network error",
        "details": e.response?.data,
      },
      statusCode: e.response?.statusCode ?? -1,
    );
  }
}
