import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/ui/splash/splash_view.dart';
import 'package:padelgo/ui/scaffold_view.dart';
import 'package:padelgo/ui/login/login_view.dart';
import 'package:padelgo/ui/home/home_view.dart';
import 'package:padelgo/ui/activity/activity_view.dart';
import 'package:padelgo/ui/community/event_view.dart';
import 'package:padelgo/ui/profile/profile_view.dart';
import 'package:padelgo/ui/membership/membership_view.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const activity = '/activity';
  static const community = '/community';
  static const profile = '/profile';
  static const membership = '/membership';
}

class RouterConfig {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final authService = GetIt.I<AuthenticationService>();
      final isLoggedIn = await authService.isLoggedIn();
      final isGoingToLogin = state.matchedLocation == AppRoutes.login;

      if (isLoggedIn && isGoingToLogin) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.membership,
        name: 'membership',
        builder: (context, state) => const MembershipView(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldView(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeView(),
            ),
          ),
          GoRoute(
            path: AppRoutes.activity,
            name: 'activity',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ActivityView(),
            ),
          ),
          GoRoute(
            path: AppRoutes.community,
            name: 'community',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventView(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileView(),
            ),
          ),
        ],
      ),
    ],
  );
}
