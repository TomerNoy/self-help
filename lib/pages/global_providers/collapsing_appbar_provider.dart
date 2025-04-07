import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collapsing_appbar_provider.g.dart';

enum AppBarType { collapsed, expanded, fullScreen }

@immutable
class AppBarState {
  final AppBarType appBarType;
  final String? appBarTitle;
  final String? fullScreenTitle;
  final String? subtitle;
  final String? logo;
  final bool hasBackButton;
  final VoidCallback? startCallback;

  const AppBarState({
    required this.appBarType,
    this.appBarTitle,
    this.fullScreenTitle,
    this.subtitle,
    this.logo,
    this.hasBackButton = false,
    this.startCallback,
  });

  AppBarState copyWith({
    required AppBarType appBarType,
    String? appBarTitle,
    String? fullScreenTitle,
    String? subtitle,
    String? logo,
    bool? hasBackButton,
    VoidCallback? startCallback,
  }) {
    return AppBarState(
      appBarType: appBarType,
      appBarTitle: appBarTitle,
      fullScreenTitle: fullScreenTitle,
      subtitle: subtitle,
      logo: logo,
      hasBackButton: hasBackButton ?? false,
      startCallback: startCallback,
    );
  }

  @override
  String toString() {
    return 'AppBarState(appBarType: $appBarType, title: $appBarTitle, subtitle: $subtitle, hasBackButton: $hasBackButton, hasStartButton: $startCallback, hasLogo: $logo, fullScreenTitle: $fullScreenTitle)';
  }
}

@riverpod
class AnimatedAppBar extends _$AnimatedAppBar {
  @override
  AppBarState build() {
    return AppBarState(
      appBarType: AppBarType.collapsed,
    );
  }

  void updateState({
    required AppBarType appBarType,
    String? appBarTitle,
    String? fullScreenTitle,
    String? subtitle,
    String? logo,
    bool? hasBackButton,
    VoidCallback? startCallback,
  }) {
    state = state.copyWith(
      appBarType: appBarType,
      appBarTitle: appBarTitle,
      fullScreenTitle: fullScreenTitle,
      subtitle: subtitle,
      logo: logo,
      hasBackButton: hasBackButton ?? false,
      startCallback: startCallback,
    );
  }
}
