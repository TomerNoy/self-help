import 'package:flutter/material.dart';
import 'package:self_help/core/app.dart';
import 'package:self_help/pages/breathing.dart';
import 'package:self_help/pages/butterfly.dart';
import 'package:self_help/pages/emergency_level.dart';
import 'package:self_help/pages/measure_level.dart';
import 'package:self_help/pages/protocol_landing.dart';
import 'package:self_help/services/services.dart';

class AppRoutes {
  static const app = '/';
  static const protocol = '/protocol';
  static const measure = '/measure';
  static const emergency = '/emergency';
  static const butterfly = '/butterfly';
  static const breathing = '/breathing';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    loggerService.debug('generateRoute: ${settings.name}');
    switch (settings.name) {
      case app:
        return MaterialPageRoute(
          builder: (_) => const App(),
          settings: RouteSettings(name: app),
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
