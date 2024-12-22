import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calc_exercise_provider.g.dart';

class CalcExerciseState {
  final int firstNumber;
  final int secondNumber;
  final String operation;
  final int result;

  CalcExerciseState({
    required this.firstNumber,
    required this.secondNumber,
    required this.operation,
    required this.result,
  });

  CalcExerciseState.copyWith({
    required CalcExerciseState state,
    int? firstNumber,
    int? secondNumber,
    String? operation,
    int? result,
  }) : this(
          firstNumber: firstNumber ?? state.firstNumber,
          secondNumber: secondNumber ?? state.secondNumber,
          operation: operation ?? state.operation,
          result: result ?? state.result,
        );
}

@riverpod
class CalcExercise extends _$CalcExercise {
  @override
  List<CalcExerciseState> build() {
    return List.generate(
      5,
      (index) {
        final firstRandom = _getRandomInt();
        final secondRandom = _getRandomInt();
        final operation = _getRandomOperation();
        final result = operation == '+'
            ? firstRandom + secondRandom
            : operation == '-'
                ? firstRandom - secondRandom
                : firstRandom * secondRandom;
        return CalcExerciseState(
          firstNumber: firstRandom,
          secondNumber: secondRandom,
          operation: operation,
          result: result,
        );
      },
    );
  }

  int _getRandomInt() => Random().nextInt(9) + 1;
  String _getRandomOperation() {
    const operations = ['-', '+', 'x'];
    final random = Random();
    return operations[random.nextInt(operations.length)];
  }
}
