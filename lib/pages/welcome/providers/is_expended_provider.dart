import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_expended_provider.g.dart';

@riverpod
class IsExpended extends _$IsExpended {
  @override
  bool build() => true;

  void toggle() => state = !state;
}
