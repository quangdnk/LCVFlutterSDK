import '../core/logger.dart';
import '../model/auth_status.dart';
import '../service/auth_service.dart';

class AuthViewModel {
  final AuthService _authService = AuthService();

  void init(String token) {
    log('Initializing with token: $token');
    _authService.init(token);
  }

  AuthStatus getStatus() {
    final status = _authService.getStatus();
    log('Auth status: $status');
    return status;
  }
}
