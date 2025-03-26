import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'stress_track.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class StressTrack extends Equatable {
  DateTime date;
  int stressLevel;

  StressTrack({
    required this.date,
    required this.stressLevel,
  });

  factory StressTrack.fromJson(Map<String, dynamic> json) =>
      _$StressTrackFromJson(json);

  Map<String, dynamic> toJson() => _$StressTrackToJson(this);

  @override
  List<Object?> get props => [date, stressLevel];
}
