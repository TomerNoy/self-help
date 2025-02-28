import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/breathing/breathing.dart';
import 'package:self_help/pages/calculate_exercise/calc_exercise.dart';
import 'package:self_help/pages/enter_number/enter_number.dart';
import 'package:self_help/pages/enter_number_reversed/enter_number_reversed.dart';
import 'package:self_help/pages/main_shell/main_shell.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:self_help/pages/home/home.dart';
import 'package:self_help/pages/home_shell/home_shell.dart';
import 'package:self_help/pages/login/login.dart';
import 'package:self_help/pages/look_around_exercise/look_around_exercise.dart';
import 'package:self_help/pages/magic_touch/magic_touch.dart';
import 'package:self_help/pages/profile/profile.dart';
import 'package:self_help/pages/register/register.dart';
import 'package:self_help/pages/repeat_number.dart/repeat_number.dart';
import 'package:self_help/pages/resilience/resilience.dart';
import 'package:self_help/pages/resilience_shell/resilience_shell.dart';
import 'package:self_help/pages/settings/settings.dart';
import 'package:self_help/pages/sos_landing/sos_landing.dart';
import 'package:self_help/pages/stress_level/stress_level.dart';
import 'package:self_help/pages/thought_release/thought_release.dart';
import 'package:self_help/pages/welcome/welcome.dart';

GoRouter router({
  GoRouterRedirect? redirect,
  GlobalKey<NavigatorState>? routerKey,
  required ValueNotifier<UserAuthState> refreshListenable,
}) {
  return GoRouter(
    debugLogDiagnostics: true,
    redirect: redirect,
    navigatorKey: routerKey,
    refreshListenable: refreshListenable,
    routes: [
      ShellRoute(
          builder: (context, state, child) {
            final page = RoutePaths.fromPath(state.fullPath ?? '');
            return MainShell(page: page, child: child);
          },
          routes: [
            GoRoute(
              path: RoutePaths.welcome.path,
              name: RoutePaths.welcome.name,
              builder: (context, state) => const Welcome(),
            ),
            GoRoute(
              path: RoutePaths.sosLanding.path,
              name: RoutePaths.sosLanding.name,
              builder: (context, state) => SosLanding(),
            ),
            GoRoute(
              path: RoutePaths.login.path,
              name: RoutePaths.login.name,
              builder: (context, state) => const Login(),
            ),
            GoRoute(
              path: RoutePaths.register.path,
              name: RoutePaths.register.name,
              builder: (context, state) => const Register(),
            ),
            ShellRoute(
              builder: (context, state, child) {
                final page = RoutePaths.fromPath(state.fullPath ?? '');
                return HomeShell(page: page, child: child);
              },
              routes: [
                GoRoute(
                  path: RoutePaths.home.path,
                  name: RoutePaths.home.name,
                  builder: (context, state) => const Home(),
                ),
                GoRoute(
                  path: RoutePaths.profile.path,
                  name: RoutePaths.profile.name,
                  builder: (context, state) => const Profile(),
                ),
                GoRoute(
                  path: RoutePaths.settings.path,
                  name: RoutePaths.settings.name,
                  builder: (context, state) => const Settings(),
                ),
              ],
            ),
            GoRoute(
              path: RoutePaths.thoughtRelease.path,
              name: RoutePaths.thoughtRelease.name,
              builder: (context, state) => const ThoughtRelease(),
            ),
            ShellRoute(
              builder: (context, state, child) {
                final page = RoutePaths.fromPath(state.fullPath ?? '');
                return ResilienceShell(page: page, child: child);
              },
              routes: [
                GoRoute(
                  path: RoutePaths.resilience.path,
                  name: RoutePaths.resilience.name,
                  builder: (context, state) => const Resilience(),
                ),
                // todo add routes for resilience
              ],
            ),
            GoRoute(
              path: RoutePaths.calculateExercise.path,
              name: RoutePaths.calculateExercise.name,
              builder: (context, state) => const CalcExercise(),
            ),
            GoRoute(
              path: RoutePaths.lookAroundExercise.path,
              name: RoutePaths.lookAroundExercise.name,
              builder: (context, state) => const LookAroundExercise(),
            ),
            GoRoute(
              path: RoutePaths.enterNumber.path,
              name: RoutePaths.enterNumber.name,
              builder: (context, state) => const EnterNumber(),
            ),
            GoRoute(
              path: RoutePaths.enterNumberReversed.path,
              name: RoutePaths.enterNumberReversed.name,
              builder: (context, state) {
                final userNUmber = state.pathParameters['userNumber'] ?? '';
                return EnterNumberReversed(
                  userNumber: userNUmber,
                );
              },
            ),
            GoRoute(
              path: RoutePaths.stressLevel.path,
              name: RoutePaths.stressLevel.name,
              builder: (context, state) => const StressLevel(),
            ),
            GoRoute(
              path: RoutePaths.repeatNumber.path,
              name: RoutePaths.repeatNumber.name,
              builder: (context, state) => const RepeatNumber(),
            ),
            GoRoute(
              path: RoutePaths.magicTouch.path,
              name: RoutePaths.magicTouch.name,
              builder: (context, state) => const MagicTouch(),
            ),
            GoRoute(
              path: RoutePaths.breathing.path,
              name: RoutePaths.breathing.name,
              builder: (context, state) => const Breathing(),
            ),
          ]),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('Page not found')),
    ),
  );
}
