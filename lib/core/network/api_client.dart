import 'package:LCVFlutterSDK/core/constants/http_constants.dart';
import 'package:LCVFlutterSDK/core/models/sdk_model_request.dart';
import 'package:LCVFlutterSDK/core/network/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/sdk_config.dart';
import '../config/sdk_session.dart';

abstract class IApiClient {
  Future<Result> get(
    String path, {
    SdkModelRequest? queryParameters,
    Options? options,
  });
  Future<Result> post(
    String path,
    SdkModelRequest? queryParameters, {
    dynamic data,
    Options? options,
  });

  Future<Result> put(
    String path,
    SdkModelRequest? queryParameters, {
    dynamic data,
    Options? options,
  });

  Future<Result> delete(String path, {Options? options});
}

class ApiClient implements IApiClient {
  final Dio _dio;

  ApiClient(SdkConfig config)
    : _dio = Dio(
        BaseOptions(
          baseUrl: config.env.endpoint(),
          connectTimeout: config.timeout,
          receiveTimeout: config.timeout,
          headers: HttpConstants.defaultHeaders,
        ),
      );

  Options _buildOptions([Options? options]) {
    final token = SdkSession.shared.token;
    final headers = Map<String, dynamic>.from(options?.headers ?? {});
    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }
    return (options ?? Options()).copyWith(headers: headers);
  }

  /// GET
  @override
  Future<Result> get(
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
      return Result.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// POST
  @override
  Future<Result> post(
    String path,
    SdkModelRequest? queryParameters, {
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
      return Result.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// PUT
  @override
  Future<Result> put(
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
      return Result.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// DELETE
  @override
  Future<Result> delete(String path, {Options? options}) async {
    try {
      final response = await _dio.delete(path, options: _buildOptions(options));
      return Result.fromJson(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Result _handleError(DioException e) {
    return Result(
      data: {
        "error": e.message ?? "Network error",
        "details": e.response?.data,
      },
      statusCode: e.response?.statusCode ?? -1,
    );
  }
}
