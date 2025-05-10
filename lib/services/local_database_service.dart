import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:self_help/models/diary_thought.dart';
import 'package:self_help/services/logger_service.dart';

class LocalDatabaseService {
  final path = Directory.current.path;
  Box<Map<dynamic, dynamic>>? _box;
  static const String boxName = 'thoughts';

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    _box = await Hive.openBox<Map<dynamic, dynamic>>(boxName);
  }

  Future<void> saveThought(DiaryThought thought) async {
    if (_box == null) await init();
    try {
      await _box!.put(thought.date.toIso8601String(), thought.toJson());
    } catch (e) {
      LoggerService.error('Error saving thought', e);
      rethrow;
    }
  }

  Future<List<DiaryThought>> getThoughts() async {
    if (_box == null) await init();
    try {
      return _box!.values
          .map((json) => DiaryThought.fromJson(json.cast()))
          .toList();
    } catch (e) {
      LoggerService.error('Error getting thoughts', e);
      rethrow;
    }
  }

  Future<DiaryThought?> getThoughtByDate(DateTime date) async {
    if (_box == null) await init();
    try {
      final key = date.toIso8601String();

      LoggerService.debug('Getting thought by date: $key');

      LoggerService.debug('all keys in box: ${_box!.keys}');

      final Map? json = _box!.get(key);

      LoggerService.debug('Thought json: $json');

      if (json == null) return null;
      final thought = DiaryThought.fromJson(json.cast());
      return thought;
    } catch (e) {
      LoggerService.error('Error getting thought by date', e);
      rethrow;
    }
  }

  Future<void> deleteThought(DateTime date) async {
    if (_box == null) await init();
    try {
      await _box!.delete(date.toIso8601String());
    } catch (e) {
      LoggerService.error('Error deleting thought', e);
      rethrow;
    }
  }

  Future<void> deleteAllThoughts() async {
    if (_box == null) await init();
    try {
      await _box!.clear();
    } catch (e) {
      LoggerService.error('Error deleting all thoughts', e);
      rethrow;
    }
  }

  Future<void> dispose() async {
    try {
      await _box?.close();
    } catch (e) {
      LoggerService.error('Error closing box', e);
      rethrow;
    }
  }
}
