import 'package:padelgo/models/auth_response.dart';

abstract class AuthenticationService<T> {
  Future<AuthResponse?> signInWithEmailAndPassword(
      String email, String password);
  Future<AuthResponse?> createUserWithEmailAndPassword(
    String name,
    String email,
    String phone,
    String password,
    String passwordConfirmation,
  );
  Future<void> signOut();
  Future<bool> isLoggedIn();
}
