import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/pages/breathing/breathing.dart';
import 'package:self_help/pages/calculate_exercise/calc_exercise.dart';
import 'package:self_help/pages/connecting/connecting.dart';
import 'package:self_help/pages/enter_number/enter_number.dart';
import 'package:self_help/pages/enter_number_reversed/enter_number_reversed.dart';
import 'package:self_help/pages/home/home.dart';
import 'package:self_help/pages/login/login.dart';
import 'package:self_help/pages/register/register.dart';
import 'package:self_help/pages/sos_landing/sos_landing.dart';
import 'package:self_help/pages/stress_level/stress_level.dart';

GoRouter router({GoRouterRedirect? redirect}) => GoRouter(
      debugLogDiagnostics: true,
      redirect: redirect,
      routes: [
        GoRoute(
          path: RoutPaths.login,
          name: RouteNames.login,
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: RoutPaths.register,
          name: RouteNames.register,
          builder: (context, state) => const Register(),
        ),
        GoRoute(
          path: RoutPaths.connecting,
          name: RouteNames.connecting,
          builder: (context, state) => const Connecting(),
        ),
        GoRoute(
          path: RoutPaths.home,
          name: RouteNames.home,
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: RoutPaths.sosLanding,
          name: RouteNames.sosLanding,
          builder: (context, state) => const SosLanding(),
        ),
        GoRoute(
          path: RoutPaths.calculateExercise,
          name: RouteNames.calculateExercise,
          builder: (context, state) => const CalcExercise(),
        ),
        GoRoute(
          path: RoutPaths.enterNumber,
          name: RouteNames.enterNumber,
          builder: (context, state) => const EnterNumber(),
        ),
        GoRoute(
          path: RoutPaths.enterNumberReversed,
          name: RouteNames.enterNumberReversed,
          builder: (context, state) {
            final userNUmber = state.pathParameters['userNumber'] ?? '';
            return EnterNumberReversed(
              userNumber: userNUmber,
            );
          },
        ),
        GoRoute(
          path: RoutPaths.stressLevel,
          name: RouteNames.stressLevel,
          builder: (context, state) => const StressLevel(),
        ),
        GoRoute(
          path: RoutPaths.breathing,
          name: RouteNames.breathing,
          builder: (context, state) => const Breathing(),
        ),
      ],
      errorBuilder: (context, state) => const Scaffold(
        body: Center(child: Text('Page not found')),
      ),
    );

class RouteNames {
  static const login = 'welcome';
  static const register = 'register';
  static const enterNumber = 'enterNumber';
  static const enterNumberReversed = 'enterNumberReversed';
  static const connecting = 'connecting';
  static const home = 'home';
  static const sosLanding = 'sos';
  static const calculateExercise = 'calculateExercise';
  // static const protocol = 'protocol';
  static const stressLevel = 'stressLevel';
  static const emergency = 'emergency';
  static const butterfly = 'butterfly';
  static const breathing = 'breathing';
}

class RoutPaths {
  static const login = '/';
  static const register = '/register';
  static const enterNumber = '/enterNumber';
  static const enterNumberReversed = '/enterNumberReversed:userNumber';
  static const connecting = '/connecting';
  static const home = '/home';
  static const sosLanding = '/sos';
  static const calculateExercise = '/calculateExercise';
  // static const protocol = '/protocol';
  static const stressLevel = '/stressLevel';
  static const emergency = '/emergency';
  static const butterfly = '/butterfly';
  static const breathing = '/breathing';
}
