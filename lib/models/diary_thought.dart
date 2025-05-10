import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_thought.freezed.dart';
part 'diary_thought.g.dart';

@freezed
abstract class DiaryThought with _$DiaryThought {
  const factory DiaryThought({
    required DateTime date,
    required String content,
  }) = _DiaryThought;

  factory DiaryThought.fromJson(Map<String, Object?> json) =>
      _$DiaryThoughtFromJson(json);
}
