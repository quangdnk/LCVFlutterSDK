/// SDK configuration container
class SdkConfig {
  final Environment env;
  final Duration timeout;
  final String xApiKey;
  final String appVersion;
  final Map<String, String>? headers;

  const SdkConfig({
    required this.env,
    required this.appVersion,
    required this.xApiKey,
    this.timeout = const Duration(seconds: 15),
    this.headers,
  });
}

enum Environment { dev, stg, prod }

extension EnvironmentExtension on Environment {
  String endpoint() {
    switch (this) {
      case Environment.dev:
        return "";
      case Environment.stg:
        return "https://lcvserverdemo.onrender.com/";
      case Environment.prod:
        return "";
    }
  }
}
