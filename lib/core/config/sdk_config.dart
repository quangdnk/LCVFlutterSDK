/// SDK configuration container
class SdkConfig {
  final String baseUrl;
  final Duration timeout;
  final bool enableLogging;
  final int retryAttempts;
  final Duration retryDelay;
  final bool enablePrettyLogger;

  const SdkConfig({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 15),
    this.enableLogging = false,
    this.retryAttempts = 2,
    this.retryDelay = const Duration(milliseconds: 500),
    this.enablePrettyLogger = false,
  });

  SdkConfig copyWith({
    String? baseUrl,
    Duration? timeout,
    bool? enableLogging,
    int? retryAttempts,
    Duration? retryDelay,
    bool? enablePrettyLogger,
  }) {
    return SdkConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      timeout: timeout ?? this.timeout,
      enableLogging: enableLogging ?? this.enableLogging,
      retryAttempts: retryAttempts ?? this.retryAttempts,
      retryDelay: retryDelay ?? this.retryDelay,
      enablePrettyLogger: enablePrettyLogger ?? this.enablePrettyLogger,
    );
  }
}
