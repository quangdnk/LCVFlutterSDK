void log(String message) {
  final timestamp = DateTime.now().toIso8601String();
  print('[SDK] [$timestamp] $message');
}
