import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'exercise_result.g.dart';

enum ExerciseType {
  breathing,
  calc,
  lookAround,
  repeat,
}

@JsonSerializable()
class ExerciseResult extends Equatable {
  final DateTime date;
  final ExerciseType exerciseType;

  const ExerciseResult({
    required this.date,
    required this.exerciseType,
  });

  factory ExerciseResult.fromJson(Map<String, dynamic> json) =>
      _$ExerciseResultFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseResultToJson(this);

  @override
  List<Object?> get props => [date, exerciseType];
}
