import 'package:flutter/material.dart';
import 'package:self_help/pages/breathing.dart';
import 'package:self_help/pages/butterfly.dart';
import 'package:self_help/pages/connecting/connecting.dart';
import 'package:self_help/pages/emergency_level.dart';
import 'package:self_help/pages/home.dart';
import 'package:self_help/pages/measure_level.dart';
import 'package:self_help/pages/protocol_landing.dart';
import 'package:self_help/pages/register/register.dart';
import 'package:self_help/pages/welcome/welcome.dart';
import 'package:self_help/services/services.dart';

class AppRoutes {
  static const welcome = '/';
  static const home = '/home';
  static const register = '/register';
  static const connecting = '/connecting';
  static const protocol = '/protocol';
  static const measure = '/measure';
  static const emergency = '/emergency';
  static const butterfly = '/butterfly';
  static const breathing = '/breathing';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    loggerService.debug('generateRoute: ${settings.name}');
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
            builder: (context) => const Welcome(),
            settings: RouteSettings(name: welcome));

      case register:
        return MaterialPageRoute(
            builder: (context) => const Register(),
            settings: RouteSettings(name: register));

      case connecting:
        return MaterialPageRoute(
            builder: (context) => const Connecting(),
            settings: RouteSettings(name: connecting));

      case home:
        return MaterialPageRoute(
          builder: (_) => const Home(),
          settings: RouteSettings(name: home),
        );

      case protocol:
        return MaterialPageRoute(
            builder: (context) => const ProtocolLanding(),
            settings: RouteSettings(name: protocol));

      case measure:
        return MaterialPageRoute(
            builder: (context) => const MeasureLevel(),
            settings: RouteSettings(name: measure));

      case emergency:
        return MaterialPageRoute(
            builder: (context) => const EmergencyLevel(),
            settings: RouteSettings(name: emergency));

      case butterfly:
        return MaterialPageRoute(
            builder: (context) => const Butterfly(),
            settings: RouteSettings(name: butterfly));

      case breathing:
        return MaterialPageRoute(
            builder: (context) => const Breathing(),
            settings: RouteSettings(name: breathing));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
          settings: RouteSettings(name: 'not_found'),
        );
    }
  }
}
