import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService<T> {
  Future<User?> signInWithEmailAndPassword(String phoneno, String password);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<bool> isAlreadyLoggedIn();
  void signOut();
  bool isLoggedIn();
  dynamic getCurrentLoginInfo();
  Future<void> clearLoginInfo();
}
