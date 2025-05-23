import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:self_help/services/app_lifecycle_service.dart';
import 'package:self_help/services/firebase_service.dart';
import 'package:self_help/services/local_database_service.dart';
import 'package:self_help/services/logger_service.dart';
import 'package:self_help/services/storage_service.dart';
import 'package:self_help/services/user_auth_service.dart';
import 'package:self_help/services/user_data_service.dart';
import 'package:self_help/services/user_profile_service.dart';

class ServiceProvider {
  static final _getIt = GetIt.instance;

  static Future<void> init() async {
    try {
      // load env
      await dotenv.load(fileName: ".env");

      // firebase
      _getIt.registerSingletonAsync<FirebaseService>(
        () async {
          final firebaseService = FirebaseService();
          await firebaseService.init();
          return firebaseService;
        },
      );

      // TODO: separate logged in and logged out services

      // storage
      _getIt.registerSingletonAsync<StorageService>(
        () async {
          final storageService = StorageService();
          await storageService.init();
          return storageService;
        },
      );

      // local database
      _getIt.registerSingletonAsync<LocalDatabaseService>(
        () async {
          final localDatabaseService = LocalDatabaseService();
          await localDatabaseService.init();
          return localDatabaseService;
        },
        dispose: (service) => service.dispose(),
      );

      await _getIt.allReady();

      // app life cycle
      _getIt.registerSingleton<AppLifeCycleService>(
        AppLifeCycleService(),
      );

      // user auth service
      _getIt.registerSingleton<UserAuthService>(UserAuthService(),
          dispose: (service) => service.dispose);

      await _getIt.allReady();

      // user profile service
      _getIt.registerSingleton<UserProfileService>(UserProfileService(),
          dispose: (service) => service.dispose);

      // user data service
      _getIt.registerSingleton<UserDataService>(UserDataService());

      await _getIt.allReady();
    } catch (e, st) {
      LoggerService.error('services error', e, st);
    }
  }
}

StorageService get storageService {
  return ServiceProvider._getIt.get<StorageService>();
}

AppLifeCycleService get appLifeCycleService {
  return ServiceProvider._getIt.get<AppLifeCycleService>();
}

UserAuthService get userAuthService =>
    ServiceProvider._getIt.get<UserAuthService>();

UserProfileService get userProfileService =>
    ServiceProvider._getIt.get<UserProfileService>();

UserDataService get userDataService =>
    ServiceProvider._getIt.get<UserDataService>();

LocalDatabaseService get localDatabaseService =>
    ServiceProvider._getIt.get<LocalDatabaseService>();
