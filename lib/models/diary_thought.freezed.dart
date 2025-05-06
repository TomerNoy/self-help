// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_thought.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiaryThought {
  DateTime get date;
  String get content;

  /// Create a copy of DiaryThought
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiaryThoughtCopyWith<DiaryThought> get copyWith =>
      _$DiaryThoughtCopyWithImpl<DiaryThought>(
          this as DiaryThought, _$identity);

  /// Serializes this DiaryThought to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiaryThought &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, content);

  @override
  String toString() {
    return 'DiaryThought(date: $date, content: $content)';
  }
}

/// @nodoc
abstract mixin class $DiaryThoughtCopyWith<$Res> {
  factory $DiaryThoughtCopyWith(
          DiaryThought value, $Res Function(DiaryThought) _then) =
      _$DiaryThoughtCopyWithImpl;
  @useResult
  $Res call({DateTime date, String content});
}

/// @nodoc
class _$DiaryThoughtCopyWithImpl<$Res> implements $DiaryThoughtCopyWith<$Res> {
  _$DiaryThoughtCopyWithImpl(this._self, this._then);

  final DiaryThought _self;
  final $Res Function(DiaryThought) _then;

  /// Create a copy of DiaryThought
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? content = null,
  }) {
    return _then(_self.copyWith(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DiaryThought implements DiaryThought {
  const _DiaryThought({required this.date, required this.content});
  factory _DiaryThought.fromJson(Map<String, dynamic> json) =>
      _$DiaryThoughtFromJson(json);

  @override
  final DateTime date;
  @override
  final String content;

  /// Create a copy of DiaryThought
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiaryThoughtCopyWith<_DiaryThought> get copyWith =>
      __$DiaryThoughtCopyWithImpl<_DiaryThought>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DiaryThoughtToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiaryThought &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, content);

  @override
  String toString() {
    return 'DiaryThought(date: $date, content: $content)';
  }
}

/// @nodoc
abstract mixin class _$DiaryThoughtCopyWith<$Res>
    implements $DiaryThoughtCopyWith<$Res> {
  factory _$DiaryThoughtCopyWith(
          _DiaryThought value, $Res Function(_DiaryThought) _then) =
      __$DiaryThoughtCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime date, String content});
}

/// @nodoc
class __$DiaryThoughtCopyWithImpl<$Res>
    implements _$DiaryThoughtCopyWith<$Res> {
  __$DiaryThoughtCopyWithImpl(this._self, this._then);

  final _DiaryThought _self;
  final $Res Function(_DiaryThought) _then;

  /// Create a copy of DiaryThought
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? content = null,
  }) {
    return _then(_DiaryThought(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
