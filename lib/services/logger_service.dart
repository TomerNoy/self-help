import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger(
    printer: _ColoredLogPrinter(),
    output: ConsoleOutput(),
    filter: DevelopmentFilter(),
  );

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
  static void wtf(String message) => _logger.f(message);
}

class _ColoredLogPrinter extends LogPrinter {
  static const String debugColor = '\x1B[32m';
  static const String infoColor = '\x1B[36m	';
  static const String errorColor = '\x1B[31m';
  static const String warningColor = '\x1B[33m';
  static const String wtfColor = '\x1B[35m';
  static const String resetColor = '\u001b[0m';

  @override
  List<String> log(LogEvent event) {
    final time = '${event.time.hour}:${event.time.minute}:${event.time.second}';
    final level = event.level;
    final name = level.name;
    final msg = event.message;
    final e = event.error;
    final st = event.stackTrace;

    final color = switch (level) {
      Level.debug => debugColor,
      Level.info => infoColor,
      Level.warning => warningColor,
      Level.error => errorColor,
      Level.fatal => wtfColor,
      _ => debugColor,
    };

    final output = ['$color$name $time: $msg$resetColor'];

    if (event.error != null) {
      output.add('$errorColor$e$resetColor');
    }

    if (st != null) {
      output.add('$errorColor$st$resetColor');
    }

    return output;
  }
}
