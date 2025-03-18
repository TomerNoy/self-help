import 'package:equatable/equatable.dart';
import 'package:self_help/core/constants/routes_constants.dart';

class Exercise extends Equatable {
  const Exercise({
    required this.path,
    required this.description,
    required this.title,
    required this.imagePath,
  });

  final RoutePaths path;
  final String description;
  final String title;
  final String imagePath;

  @override
  List<Object> get props => [path, description, title];
}
