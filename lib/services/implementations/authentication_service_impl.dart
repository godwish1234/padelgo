import 'package:get_it/get_it.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/models/auth_response.dart';
import 'package:padelgo/repository/interfaces/authentication_repository.dart';
import 'package:padelgo/utils/secure_storage_util.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  final AuthenticationRepository _authRepository =
      GetIt.I<AuthenticationRepository>();

  @override
  Future<AuthResponse?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _authRepository.login(email, password);
  }

  @override
  Future<AuthResponse?> createUserWithEmailAndPassword(
    String name,
    String email,
    String phone,
    String password,
    String passwordConfirmation,
  ) async {
    return await _authRepository.register(
      name,
      email,
      phone,
      password,
      passwordConfirmation,
    );
  }

  @override
  Future<void> signOut() async {
    return await _authRepository.logout();
  }

  @override
  Future<bool> isLoggedIn() async {
    final authToken = await SecureStorageUtil.getAuthToken();
    return authToken != null && authToken.isNotEmpty;
  }
}
