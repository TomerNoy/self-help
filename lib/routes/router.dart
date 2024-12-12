import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/pages/breathing.dart';
import 'package:self_help/pages/butterfly.dart';
import 'package:self_help/pages/connecting/connecting.dart';
import 'package:self_help/pages/emergency_level.dart';
import 'package:self_help/pages/home.dart';
import 'package:self_help/pages/measure_level.dart';
import 'package:self_help/pages/protocol_landing.dart';
import 'package:self_help/pages/register/register.dart';
import 'package:self_help/pages/welcome/welcome.dart';

GoRouter router({GoRouterRedirect? redirect}) => GoRouter(
      debugLogDiagnostics: true,
      redirect: redirect,
      routes: [
        GoRoute(
          path: RoutPaths.welcome,
          name: AppRoutes.welcome,
          builder: (context, state) => const Welcome(),
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
          path: RoutPaths.protocol,
          name: AppRoutes.protocol,
          builder: (context, state) => const ProtocolLanding(),
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
  static const welcome = 'welcome';
  static const register = 'register';
  static const connecting = 'connecting';
  static const home = 'home';
  static const protocol = 'protocol';
  static const measure = 'measure';
  static const emergency = 'emergency';
  static const butterfly = 'butterfly';
  static const breathing = 'breathing';
}

class RoutPaths {
  static const welcome = '/';
  static const register = '/register';
  static const connecting = '/connecting';
  static const home = '/home';
  static const protocol = '/protocol';
  static const measure = '/measure';
  static const emergency = '/emergency';
  static const butterfly = '/butterfly';
  static const breathing = '/breathing';
}
