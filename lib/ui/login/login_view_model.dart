import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/models/auth_response.dart';

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

  void signIn(BuildContext context, String email, String password) async {
    setBusy(true);

    try {
      AuthResponse? response =
          await _auth.signInWithEmailAndPassword(email, password);

      if (response != null && response.success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? ''),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRoutes.home);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Please check your credentials.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        debugPrint('Login failed');
      }
    } catch (e) {
      debugPrint('Login error: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    setBusy(true);

    try {
      // Google Sign-In is not currently implemented with the custom backend
      debugPrint(
          'Google Sign-In is not currently configured with custom backend');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google Sign-In not available yet'),
            backgroundColor: Colors.orange,
          ),
        );
      }
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
      // Facebook Sign-In is not currently implemented with the custom backend
      debugPrint(
          'Facebook Sign-In is not currently configured with custom backend');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Facebook Sign-In not available yet'),
            backgroundColor: Colors.orange,
          ),
        );
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
