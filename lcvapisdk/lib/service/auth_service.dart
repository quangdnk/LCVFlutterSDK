import '../model/auth_status.dart';

class AuthService {
  String? _token;
  AuthStatus _status = AuthStatus.unknown;

  void init(String token) {
    _token = token;
    _status =
        token.isNotEmpty
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated;
  }

  AuthStatus getStatus() {
    return _status;
  }
}
