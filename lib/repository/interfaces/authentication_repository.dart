import 'package:padelgo/models/auth_response.dart';

abstract class AuthenticationRepository {
  Future<AuthResponse?> login(String email, String password);
  Future<AuthResponse?> register(
    String name,
    String email,
    String phone,
    String password,
    String passwordConfirmation,
  );
  Future<void> logout();
}
