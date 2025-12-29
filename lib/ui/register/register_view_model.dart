import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
      // Create user with email and password
      User? user = await _auth.createUserWithEmailAndPassword(email, password);

      if (user != null) {
        // Update display name
        await user.updateDisplayName(name);

        // TODO: Save additional user data (phone, etc.) to Firestore if needed
        // await _profileService.updateProfile(name: name, phone: phone);

        if (context.mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
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
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during registration';

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak';
          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }

      debugPrint('Registration error: ${e.code} - ${e.message}');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      debugPrint('Registration error: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> signUpWithGoogle(BuildContext context) async {
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

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google Sign-In not configured yet'),
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
      // Trigger the Facebook authentication flow
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Sign in to Firebase with the Facebook credential
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final user = userCredential.user;

        if (user != null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Facebook sign-up successful!'),
                backgroundColor: Colors.green,
              ),
            );
            context.go(AppRoutes.home);
          }
        }
      } else if (result.status == LoginStatus.cancelled) {
        debugPrint('Facebook sign up cancelled by user');
      } else {
        debugPrint('Facebook sign up failed: ${result.message}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Facebook Sign-In failed: ${result.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
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
