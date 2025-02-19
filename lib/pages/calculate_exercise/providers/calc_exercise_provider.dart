import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/services/services.dart';

part 'calc_exercise_provider.g.dart';

class CalcExerciseState {
  final int firstNumber;
  final int secondNumber;
  final CalcOperation operation;
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
    CalcOperation? operation,
    int? result,
  }) : this(
          firstNumber: firstNumber ?? state.firstNumber,
          secondNumber: secondNumber ?? state.secondNumber,
          operation: operation ?? state.operation,
          result: result ?? state.result,
        );
}

enum CalcOperation {
  add('+'),
  subtract('-'),
  multiply('*');

  final String displayText;
  const CalcOperation(this.displayText);
}

@riverpod
class CalcExercise extends _$CalcExercise {
  @override
  List<CalcExerciseState> build() {
    return List.generate(
      5,
      (index) {
        final operation = _getRandomOperation();
        final firstRandom = _getRandomInt();
        loggerService.debug('§ firstRandom: $firstRandom');
        // if operation is subtract then first number should be greater than second number
        final secondRandom = operation == CalcOperation.subtract
            ? _getRandomInt(
                min: 1,
                max: firstRandom - 1,
              )
            : _getRandomInt();

        final result = switch (operation) {
          CalcOperation.add => firstRandom + secondRandom,
          CalcOperation.subtract => firstRandom - secondRandom,
          CalcOperation.multiply => firstRandom * secondRandom,
        };

        return CalcExerciseState(
          firstNumber: firstRandom,
          secondNumber: secondRandom,
          operation: operation,
          result: result,
        );
      },
    );
  }

  int _getRandomInt({int min = 2, int max = 10}) {
    return Random().nextInt(max - min + 1) + min;
  }

  CalcOperation _getRandomOperation() {
    const operations = CalcOperation.values;
    final random = Random();
    return operations[random.nextInt(operations.length)];
  }
}
