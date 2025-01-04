import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/routes_constants.dart';
import 'package:self_help/pages/breathing/breathing.dart';
import 'package:self_help/pages/calculate_exercise/calc_exercise.dart';
import 'package:self_help/pages/connecting/connecting.dart';
import 'package:self_help/pages/enter_number/enter_number.dart';
import 'package:self_help/pages/enter_number_reversed/enter_number_reversed.dart';
import 'package:self_help/pages/gain_thought_controll_landing/gain_thought_controll_landing.dart';
import 'package:self_help/pages/home/home.dart';
import 'package:self_help/pages/login/login.dart';
import 'package:self_help/pages/look_around_exercise/look_around_exercise.dart';
import 'package:self_help/pages/register/register.dart';
import 'package:self_help/pages/sos_landing/sos_landing.dart';
import 'package:self_help/pages/stress_level/stress_level.dart';
import 'package:self_help/pages/thought_release/thought_release.dart';
import 'package:self_help/services/services.dart';

GoRouter router({GoRouterRedirect? redirect}) {
  return GoRouter(
    debugLogDiagnostics: true,
    redirect: redirect,
    routes: [
      GoRoute(
        path: RoutPaths.login,
        name: RoutNames.login,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: RoutPaths.register,
        name: RoutNames.register,
        builder: (context, state) => const Register(),
      ),
      GoRoute(
        path: RoutPaths.connecting,
        name: RoutNames.connecting,
        builder: (context, state) => const Connecting(),
      ),
      GoRoute(
        path: RoutPaths.home,
        name: RoutNames.home,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: RoutPaths.sosLanding,
        name: RoutNames.sosLanding,
        builder: (context, state) => const SosLanding(),
      ),
      GoRoute(
        path: RoutPaths.gainControlLanding,
        name: RoutNames.gainControlLanding,
        builder: (context, state) => const GainControlLanding(),
      ),
      GoRoute(
        path: RoutPaths.thoughtRelease,
        name: RoutNames.thoughtRelease,
        builder: (context, state) => const ThoughtRelease(),
      ),
      GoRoute(
        path: RoutPaths.calculateExercise,
        name: RoutNames.calculateExercise,
        builder: (context, state) => const CalcExercise(),
      ),
      GoRoute(
        path: RoutPaths.lookAroundExercise,
        name: RoutNames.lookAroundExercise,
        builder: (context, state) => const LookAroundExercise(),
      ),
      GoRoute(
        path: RoutPaths.enterNumber,
        name: RoutNames.enterNumber,
        builder: (context, state) => const EnterNumber(),
      ),
      GoRoute(
        path: RoutPaths.enterNumberReversed,
        name: RoutNames.enterNumberReversed,
        builder: (context, state) {
          final userNUmber = state.pathParameters['userNumber'] ?? '';
          return EnterNumberReversed(
            userNumber: userNUmber,
          );
        },
      ),
      GoRoute(
        path: RoutPaths.stressLevel,
        name: RoutNames.stressLevel,
        builder: (context, state) => const StressLevel(),
      ),
      GoRoute(
        path: RoutPaths.breathing,
        name: RoutNames.breathing,
        builder: (context, state) => const Breathing(),
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('Page not found')),
    ),
  );
}
