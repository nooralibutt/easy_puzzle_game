import 'package:easy_puzzle_game/src/dashatar/colors/colors.dart';
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
  Color get backgroundColor => PuzzleColors.bluePrimary;

  @override
  Color get defaultColor => PuzzleColors.blue90;

  @override
  Color get buttonColor => PuzzleColors.blue50;

  @override
  Color get menuInactiveColor => PuzzleColors.blue50;

  @override
  Color get countdownColor => PuzzleColors.blue50;

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
}
