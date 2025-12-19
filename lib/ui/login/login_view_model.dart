import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginViewModel extends BaseViewModel {
  final _auth = GetIt.I<AuthenticationService>();
  late final AnimationController _fadeTransitionController;
  late final Animation<double> fadeTransitionAnimation;

  LoginViewModel(TickerProviderStateMixin<StatefulWidget> loginView) {
    _fadeTransitionController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: loginView,
    )..repeat(reverse: true);

    fadeTransitionAnimation = CurvedAnimation(
      parent: _fadeTransitionController,
      curve: Curves.easeIn,
    );
  }

  initialize() async {}

  void signIn(BuildContext context, String phoneno, String password) async {
    setBusy(true);

    try {
      User? user = await _auth.signInWithEmailAndPassword(phoneno, password);

      if (user != null) {
        // await _profileService.initialize(forceRefresh: true);
        if (context.mounted) {
          context.go(AppRoutes.home);
        }
      } else {
        debugPrint('error occurred');
      }
    } catch (e) {
      debugPrint('error occurred: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    setBusy(true);

    try {
      // TODO: Fix Google Sign-In implementation
      // Google Sign-In requires platform-specific configuration
      debugPrint('Google Sign-In is not currently configured');

      /* Uncomment and fix when Google Sign-In is properly configured
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        setBusy(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        if (context.mounted) {
          context.go(AppRoutes.home);
        }
      }
      */
    } catch (e) {
      debugPrint('Google sign in error: $e');
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    setBusy(true);

    try {
      // Initialize Facebook login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Get access token
        final AccessToken accessToken = result.accessToken!;

        // Create credential for Firebase
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        // Sign in with Firebase
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final user = userCredential.user;

        if (user != null) {
          // await _profileService.initialize(forceRefresh: true);
          if (context.mounted) {
            context.go(AppRoutes.home);
          }
        }
      } else if (result.status == LoginStatus.cancelled) {
        // User canceled login
        debugPrint('Facebook login canceled');
      } else {
        debugPrint('Facebook login failed with status: ${result.status}');
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Facebook sign in error: $e');
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    _fadeTransitionController.dispose();
    super.dispose();
  }
}
