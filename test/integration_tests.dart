import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:self_help/core/extensions/date_extensions.dart';
import 'package:self_help/models/diary_thought.dart';
import 'package:self_help/services/local_database_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  const String boxName = 'thoughts';
  setUp(() async {
    final methodCodec = const StandardMethodCodec();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler(
      'plugins.flutter.io/path_provider',
      (ByteData? message) async {
        final methodCall = methodCodec.decodeMethodCall(message);
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          // Return a temporary directory path for testing
          final tempDir = await Directory.systemTemp.createTemp();
          return methodCodec.encodeSuccessEnvelope(tempDir.path);
        }
        return null;
      },
    );

    // Initialize Hive in a temporary directory for testing
    final tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await Hive.openBox<Map<dynamic, dynamic>>(boxName);

    // Register real service
    getIt.reset();
    final localDatabaseService = LocalDatabaseService();
    await localDatabaseService.init();
    getIt.registerSingleton<LocalDatabaseService>(localDatabaseService);
  });

  tearDown(() async {
    // Clean up Hive and get_it
    await Hive.box<Map<dynamic, dynamic>>(boxName).clear();
    await Hive.close();
    await getIt.reset();
  });

  test('LocalDatabaseService saves, retrieves, and deletes thoughts correctly',
      () async {
    // Arrange
    final thought = DiaryThought(
      date: DateTime.now().dateOnly,
      content: 'this is some content',
    );

    // Act and Assert: Delete all thoughts
    await getIt<LocalDatabaseService>().deleteAllThoughts();
    final initialThoughts = await getIt<LocalDatabaseService>().getThoughts();
    expect(initialThoughts, isEmpty);

    // Act and Assert: Save thought
    await getIt<LocalDatabaseService>().saveThought(thought);
    final savedThought = await getIt<LocalDatabaseService>()
        .getThoughtByDate(DateTime.now().dateOnly);
    expect(savedThought, isNotNull);
    expect(savedThought!.content, thought.content);
    expect(savedThought.date, thought.date);

    // Act and Assert: Get all thoughts
    final allThoughts = await getIt<LocalDatabaseService>().getThoughts();
    expect(allThoughts, isNotEmpty);
    expect(allThoughts.length, 1);
    expect(allThoughts.first.content, thought.content);

    // Act and Assert: Delete thought
    await getIt<LocalDatabaseService>().deleteThought(DateTime.now().dateOnly);
    final deletedThought = await getIt<LocalDatabaseService>()
        .getThoughtByDate(DateTime.now().dateOnly);
    expect(deletedThought, isNull);

    // Act and Assert: Get all thoughts after delete
    final allThoughtsAfterDelete =
        await getIt<LocalDatabaseService>().getThoughts();
    expect(allThoughtsAfterDelete, isEmpty);
  });
}
