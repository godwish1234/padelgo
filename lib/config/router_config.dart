import 'package:go_router/go_router.dart';
import 'package:padelgo/ui/splash/splash_view.dart';
import 'package:padelgo/ui/scaffold_view.dart';
import 'package:padelgo/ui/login/login_view.dart';
import 'package:padelgo/ui/home/home_view.dart';
import 'package:padelgo/ui/activity/activity_view.dart';
import 'package:padelgo/ui/community/event_view.dart';
import 'package:padelgo/ui/profile/profile_view.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const activity = '/activity';
  static const community = '/community';
  static const profile = '/profile';
}

class RouterConfig {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
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
