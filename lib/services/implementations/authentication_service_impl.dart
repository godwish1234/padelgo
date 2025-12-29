import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padelgo/localizations/locale_keys.g.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> signInWithEmailAndPassword(
      String phoneno, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: phoneno, password: password);
      return credential.user;
    } catch (e) {
      Fluttertoast.showToast(
          msg: LocaleKeys.login_validation.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return null;
  }

  @override
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      debugPrint('Create user error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isAlreadyLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  dynamic getCurrentLoginInfo() {
    // Return current user info if needed by repository
    return null;
  }

  @override
  Future<void> clearLoginInfo() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
