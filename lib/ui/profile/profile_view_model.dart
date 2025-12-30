import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/services/interfaces/profile_service.dart';

class ProfileViewModel extends BaseViewModel {
  final _auth = GetIt.instance<AuthenticationService>();
  final _profileService = GetIt.instance<ProfileService>();

  dynamic _userProfile;
  dynamic get userProfile => _userProfile;

  bool get isPremiumMember => true;

  void navigateToMembershipUpgrade() {
    // Navigate to membership upgrade page
  }

  void navigateToMembershipDetails() {
    // Navigate to membership management page
  }

  Future<void> initialize() async {
    setBusy(true);
    try {
      _userProfile = await _profileService.getUserProfile();
    } catch (e) {
      debugPrint("Error fetching user profile: $e");
    } finally {
      setBusy(false);
    }
  }

  void navigateToEditProfile() {
    // TODO: Implement navigation to edit profile screen
    debugPrint("Navigate to edit profile");
  }

  void navigateToSettings() {
    // TODO: Implement navigation to settings screen
    debugPrint("Navigate to settings");
  }

  void navigateToNotifications() {
    // TODO: Implement navigation to notification preferences
    debugPrint("Navigate to notifications");
  }

  void navigateToLanguageSettings() {
    // TODO: Implement navigation to language settings
    debugPrint("Navigate to language settings");
  }

  void navigateToHelpCenter() {
    // TODO: Implement navigation to help center
    debugPrint("Navigate to help center");
  }

  void navigateToPaymentMethods() {
    // TODO: Implement navigation to payment methods
    debugPrint("Navigate to payment methods");
  }

  void navigateToContactUs() {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'support@yourdomain.com',
        queryParameters: {'subject': 'App Support Request'});
    launchUrl(emailLaunchUri);
  }

  void navigateToPrivacyPolicy() {
    launchUrl(Uri.parse("https://yourdomain.com/privacy"));
  }

  void navigateToTerms() {
    launchUrl(Uri.parse("https://yourdomain.com/terms"));
  }

  void toggleThemeMode() {
    // TODO: Toggle between light and dark mode
    debugPrint("Toggle theme");
  }

  Future<void> updateProfilePicture() async {
    // TODO: Implement image picker and update profile picture
    debugPrint("Update profile picture");
  }

  Future<void> logout(BuildContext context) async {
    setBusy(true);
    try {
      await _auth.signOut();
      if (context.mounted) {
        context.go(AppRoutes.login);
      }
    } catch (e) {
      debugPrint("Error during logout: $e");
      // Still navigate to login even if logout fails
      if (context.mounted) {
        context.go(AppRoutes.login);
      }
    } finally {
      setBusy(false);
    }
  }
}
