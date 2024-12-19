import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/pages/breathing.dart';
import 'package:self_help/pages/butterfly.dart';
import 'package:self_help/pages/connecting/connecting.dart';
import 'package:self_help/pages/emergency_level.dart';
import 'package:self_help/pages/enter_number.dart';
import 'package:self_help/pages/enter_number_reversed.dart';
import 'package:self_help/pages/home.dart';
import 'package:self_help/pages/login/login.dart';
import 'package:self_help/pages/measure_level.dart';
import 'package:self_help/pages/register/register.dart';
import 'package:self_help/pages/sos.dart';

GoRouter router({GoRouterRedirect? redirect}) => GoRouter(
      debugLogDiagnostics: true,
      redirect: redirect,
      routes: [
        GoRoute(
          path: RoutPaths.login,
          name: AppRoutes.login,
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: RoutPaths.register,
          name: AppRoutes.register,
          builder: (context, state) => const Register(),
        ),
        GoRoute(
          path: RoutPaths.connecting,
          name: AppRoutes.connecting,
          builder: (context, state) => const Connecting(),
        ),
        GoRoute(
          path: RoutPaths.home,
          name: AppRoutes.home,
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: RoutPaths.sos,
          name: AppRoutes.sos,
          builder: (context, state) => const Sos(),
        ),
        GoRoute(
          path: RoutPaths.enterNumber,
          name: AppRoutes.enterNumber,
          builder: (context, state) => const EnterNumber(),
        ),
        GoRoute(
          path: RoutPaths.enterNumberReversed,
          name: AppRoutes.enterNumberReversed,
          builder: (context, state) {
            final userNUmber = state.pathParameters['userNumber'] ?? '';
            return EnterNumberReversed(
              userNumber: userNUmber,
            );
          },
        ),
        GoRoute(
          path: RoutPaths.measure,
          name: AppRoutes.measure,
          builder: (context, state) => const MeasureLevel(),
        ),
        GoRoute(
          path: RoutPaths.emergency,
          name: AppRoutes.emergency,
          builder: (context, state) => const EmergencyLevel(),
        ),
        GoRoute(
          path: RoutPaths.butterfly,
          name: AppRoutes.butterfly,
          builder: (context, state) => const Butterfly(),
        ),
        GoRoute(
          path: RoutPaths.breathing,
          name: AppRoutes.breathing,
          builder: (context, state) => const Breathing(),
        ),
      ],
      errorBuilder: (context, state) => const Scaffold(
        body: Center(child: Text('Page not found')),
      ),
    );

class AppRoutes {
  static const login = 'welcome';
  static const register = 'register';
  static const enterNumber = 'enterNumber';
  static const enterNumberReversed = 'enterNumberReversed';
  static const connecting = 'connecting';
  static const home = 'home';
  static const sos = 'sos';
  // static const protocol = 'protocol';
  static const measure = 'measure';
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
  static const sos = '/sos';
  // static const protocol = '/protocol';
  static const measure = '/measure';
  static const emergency = '/emergency';
  static const butterfly = '/butterfly';
  static const breathing = '/breathing';
}
