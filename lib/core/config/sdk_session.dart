class SdkSession {
  // Singleton instance
  static final SdkSession _shared = SdkSession._internal();
  static SdkSession get shared => _shared;

  // Private constructor
  SdkSession._internal();

  String? token;

  String? userId;

  String? vinId;

  /// Reset session khi logout
  void clear() {
    token = null;
    userId = null;
    vinId = null;
  }
}
