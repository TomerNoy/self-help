import 'package:get_it/get_it.dart';
import 'package:self_help/services/app_lifecycle_service.dart';
import 'package:self_help/services/logger_service.dart';
import 'package:self_help/services/storage_service.dart';
import 'package:self_help/services/user_service.dart';

class ServiceProvider {
  static final _getIt = GetIt.instance;

  static Future<void> init() async {
    try {
      // logger
      _getIt.registerSingleton<LoggerService>(LoggerService());

      // storage
      _getIt.registerSingletonAsync<StorageService>(
        () async {
          final storageService = StorageService();
          await storageService.init();
          return storageService;
        },
      );

      await _getIt.allReady();

      // app life cycle
      _getIt.registerSingleton<AppLifeCycleService>(
        AppLifeCycleService(),
      );

      // user service
      _getIt.registerSingleton<UserService>(UserService(), dispose: (service) {
        service.dispose;
      });
    } catch (e, st) {
      loggerService.error('services error', e, st);
    }
  }
}

LoggerService get loggerService {
  return ServiceProvider._getIt.get<LoggerService>();
}

StorageService get storageService {
  return ServiceProvider._getIt.get<StorageService>();
}

AppLifeCycleService get appLifeCycleService {
  return ServiceProvider._getIt.get<AppLifeCycleService>();
}

UserService get userService => ServiceProvider._getIt.get<UserService>();
