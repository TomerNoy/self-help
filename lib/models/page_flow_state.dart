import 'package:flutter/material.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/services/logger_service.dart';

@immutable
class PageFlowState {
  final int index;
  final List<RoutePaths> flowList;

  const PageFlowState({
    required this.index,
    required this.flowList,
  });

  PageFlowState copyWith({
    int? index,
    List<RoutePaths>? flowList,
  }) {
    LoggerService.debug(
      'PageFlowState copyWith: $index, $flowList',
    );

    return PageFlowState(
      index: index ?? this.index,
      flowList: flowList ?? this.flowList,
    );
  }

  PageFlowState copyWithAddReplaceRoutes(List<RoutePaths> newRoutes) {
    final newFlowList = [
      ...flowList.sublist(0, index + 1),
      ...newRoutes,
    ];

    return PageFlowState(
      index: index + 1,
      flowList: newFlowList,
    );
  }

  @override
  String toString() => 'PageFlowState(index: $index, flowList: $flowList)';
}
