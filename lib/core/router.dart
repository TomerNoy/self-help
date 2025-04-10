import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/breathing/breathing.dart';
import 'package:self_help/pages/butterfly/butterfly.dart';
import 'package:self_help/pages/calculate_exercise/calc_exercise.dart';
import 'package:self_help/pages/calm_touch/calm_touch.dart';
import 'package:self_help/pages/eights/eights.dart';
import 'package:self_help/pages/for_against/for_against.dart';
import 'package:self_help/pages/magic_touch/widgets/butterfly_hug.dart';
import 'package:self_help/pages/main_shell/main_shell.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:self_help/pages/home/home.dart';
import 'package:self_help/pages/login/login.dart';
import 'package:self_help/pages/look_around_exercise/look_around_exercise.dart';
import 'package:self_help/pages/magic_touch/magic_touch.dart';
import 'package:self_help/pages/profile/profile.dart';
import 'package:self_help/pages/question/question.dart';
import 'package:self_help/pages/register/register.dart';
import 'package:self_help/pages/repeat_number.dart/repeat_number.dart';
import 'package:self_help/pages/resilience/resilience.dart';
import 'package:self_help/pages/resilience_shell/resilience_shell.dart';
import 'package:self_help/pages/settings/settings.dart';
import 'package:self_help/pages/sos_landing/sos_landing.dart';
import 'package:self_help/pages/stress_level/stress_level.dart';
import 'package:self_help/pages/thought_Identify/thought_Identify.dart';
import 'package:self_help/pages/thought_cloud/thought_cloud.dart';
import 'package:self_help/pages/thought_management/thought_management.dart';
import 'package:self_help/pages/thought_release/thought_release.dart';
import 'package:self_help/pages/welcome/welcome.dart';

final rootRouterKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
final shellRouterKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required Widget child,
  required GoRouterState state,
  Duration transitionDuration = const Duration(milliseconds: 400),
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
            secondaryAnimation,
          ),
          child: child,
        ),
      );
    },
    transitionDuration: transitionDuration,
  );
}

GoRouter router({
  GoRouterRedirect? redirect,
  required ValueNotifier<UserAuthState> authState,
  required VoidCallback updateFlowBack,
}) {
  onExit(context, state) {
    updateFlowBack();
    return true;
  }

  return GoRouter(
    debugLogDiagnostics: true,
    redirect: redirect,
    navigatorKey: rootRouterKey,
    refreshListenable: authState,
    routes: [
      ShellRoute(
          navigatorKey: shellRouterKey,
          builder: (context, state, child) {
            final page = RoutePaths.fromPath(state.fullPath ?? '');
            return MainShell(
              page: page,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: RoutePaths.welcome.path,
              name: RoutePaths.welcome.name,
              // builder: (context, state) => const Welcome(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Welcome(),
                state: state,
              ),
            ),
            GoRoute(
              path: RoutePaths.sosLanding.path,
              name: RoutePaths.sosLanding.name,
              builder: (context, state) => SosLanding(),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.login.path,
              name: RoutePaths.login.name,
              // builder: (context, state) => const Login(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Login(),
                state: state,
              ),
            ),
            GoRoute(
              path: RoutePaths.register.path,
              name: RoutePaths.register.name,
              // builder: (context, state) => const Register(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Register(),
                state: state,
              ),
            ),
            // ShellRoute(
            GoRoute(
              path: RoutePaths.home.path,
              name: RoutePaths.home.name,
              // builder: (context, state) => const Home(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Home(),
                state: state,
              ),
            ),
            GoRoute(
              path: RoutePaths.profile.path,
              name: RoutePaths.profile.name,
              // builder: (context, state) => const Profile(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Profile(),
                state: state,
              ),
            ),
            GoRoute(
              path: RoutePaths.settings.path,
              name: RoutePaths.settings.name,
              // builder: (context, state) => const Settings(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Settings(),
                state: state,
              ),
            ),
            //   ],
            // ),
            GoRoute(
              path: RoutePaths.thoughtRelease.path,
              name: RoutePaths.thoughtRelease.name,
              // builder: (context, state) => const ThoughtRelease(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const ThoughtRelease(),
                state: state,
              ),
              onExit: onExit,
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
                  // builder: (context, state) => const Resilience(),
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    child: const Resilience(),
                    state: state,
                  ),
                ),
                // TODO: add routes for resilience
              ],
            ),
            GoRoute(
              path: RoutePaths.calculateExercise.path,
              name: RoutePaths.calculateExercise.name,
              // builder: (context, state) => const CalcExercise(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const CalcExercise(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.lookAroundExercise.path,
              name: RoutePaths.lookAroundExercise.name,
              // builder: (context, state) => const LookAroundExercise(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const LookAroundExercise(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.butterfly.path,
              name: RoutePaths.butterfly.name,
              // builder: (context, state) => const LookAroundExercise(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Butterfly(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.butterflyHug.path,
              name: RoutePaths.butterflyHug.name,
              // builder: (context, state) => const LookAroundExercise(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const ButterflyHug(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.calmTouch.path,
              name: RoutePaths.calmTouch.name,
              // builder: (context, state) => const LookAroundExercise(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const CalmTouch(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.thoughtManagement.path,
              name: RoutePaths.thoughtManagement.name,
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const ThoughtManagement(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.thoughtIdentify.path,
              name: RoutePaths.thoughtIdentify.name,
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const ThoughtIdentify(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.question.path,
              name: RoutePaths.question.name,
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Question(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.forAgainst.path,
              name: RoutePaths.forAgainst.name,
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const ForAgainst(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.eights.path,
              name: RoutePaths.eights.name,
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Eights(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.thoughtCloud.path,
              name: RoutePaths.thoughtCloud.name,
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const ThoughtCloud(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.stressLevel.path,
              name: RoutePaths.stressLevel.name,
              // builder: (context, state) => const StressLevel(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const StressLevel(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.repeatNumber.path,
              name: RoutePaths.repeatNumber.name,
              // builder: (context, state) => const RepeatNumber(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const RepeatNumber(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.magicTouch.path,
              name: RoutePaths.magicTouch.name,
              // builder: (context, state) => const MagicTouch(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const MagicTouch(),
                state: state,
              ),
              onExit: onExit,
            ),
            GoRoute(
              path: RoutePaths.breathing.path,
              name: RoutePaths.breathing.name,
              // builder: (context, state) => const Breathing(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                child: const Breathing(),
                state: state,
              ),
              onExit: onExit,
            ),
          ]),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('Page not found')),
    ),
  );
}
