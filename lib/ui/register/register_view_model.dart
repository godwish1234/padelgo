import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/models/auth_response.dart';

class RegisterViewModel extends BaseViewModel {
  final _auth = GetIt.I<AuthenticationService>();
  late final AnimationController _fadeTransitionController;
  late final Animation<double> fadeTransitionAnimation;

  RegisterViewModel(TickerProviderStateMixin<StatefulWidget> registerView) {
    _fadeTransitionController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: registerView,
    )..repeat(reverse: true);

    fadeTransitionAnimation = CurvedAnimation(
      parent: _fadeTransitionController,
      curve: Curves.easeIn,
    );
  }

  initialize() async {}

  void register(
    BuildContext context,
    String name,
    String email,
    String phone,
    String password,
  ) async {
    setBusy(true);

    try {
      // Create user with the custom backend API
      AuthResponse? response = await _auth.createUserWithEmailAndPassword(
        name,
        email,
        phone,
        password,
        password, // password_confirmation
      );

      if (response != null && response.success) {
        if (context.mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          // Navigate to home
          context.go(AppRoutes.home);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration failed. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      String errorMessage = 'An error occurred during registration';

      debugPrint('Registration error: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setBusy(false);
    }
  }

  Future<void> signUpWithGoogle(BuildContext context) async {
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
      debugPrint('Google sign up error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign-In failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setBusy(false);
    }
  }

  Future<void> signUpWithFacebook(BuildContext context) async {
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
      debugPrint('Facebook sign up error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Facebook Sign-In error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
