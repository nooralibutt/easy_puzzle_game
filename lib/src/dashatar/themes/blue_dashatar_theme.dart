import 'package:easy_puzzle_game/src/dashatar/themes/dashatar_theme.dart';
import 'package:flutter/material.dart';

/// {@template blue_dashatar_theme}
/// The blue dashatar puzzle theme.
/// {@endtemplate}
class MyBlueDashatarTheme extends MyDashatarTheme {
  /// {@macro blue_dashatar_theme}
  const MyBlueDashatarTheme() : super();

  @override
  String semanticsLabel(BuildContext context) => '';

  @override
  String get themeAsset => '';

  @override
  String get successThemeAsset => '';

  @override
  String get audioControlOffAsset => '';

  @override
  String get audioAsset => '';

  @override
  String get dashAssetsDirectory => '';

  @override
  // TODO: implement backgroundColor
  Color get backgroundColor => throw UnimplementedError();

  @override
  // TODO: implement buttonColor
  Color get buttonColor => throw UnimplementedError();

  @override
  // TODO: implement countdownColor
  Color get countdownColor => throw UnimplementedError();

  @override
  // TODO: implement defaultColor
  Color get defaultColor => throw UnimplementedError();

  @override
  // TODO: implement menuInactiveColor
  Color get menuInactiveColor => throw UnimplementedError();

  @override
  // TODO: implement hoverColor
  Color get hoverColor => throw UnimplementedError();

  @override
  // TODO: implement menuActiveColor
  Color get menuActiveColor => throw UnimplementedError();

  @override
  // TODO: implement menuUnderlineColor
  Color get menuUnderlineColor => throw UnimplementedError();

  @override
  // TODO: implement nameColor
  Color get nameColor => throw UnimplementedError();

  @override
  // TODO: implement pressedColor
  Color get pressedColor => throw UnimplementedError();

  @override
  // TODO: implement titleColor
  Color get titleColor => throw UnimplementedError();
}
