import 'package:easy_puzzle_game/src/dashatar/colors/colors.dart';
import 'package:easy_puzzle_game/src/dashatar/themes/dashatar_theme.dart';
import 'package:flutter/material.dart';

/// {@template yellow_dashatar_theme}
/// The yellow dashatar puzzle theme.
/// {@endtemplate}
class MyYellowDashatarTheme extends MyDashatarTheme {
  /// {@macro yellow_dashatar_theme}
  const MyYellowDashatarTheme() : super();

  @override
  String semanticsLabel(BuildContext context) => '';

  @override
  Color get backgroundColor => PuzzleColors.yellowPrimary;

  @override
  Color get defaultColor => PuzzleColors.yellow90;

  @override
  Color get buttonColor => PuzzleColors.yellow50;

  @override
  Color get menuInactiveColor => PuzzleColors.yellow50;

  @override
  Color get countdownColor => PuzzleColors.yellow50;

  @override
  String get themeAsset => 'assets/images/dashatar/gallery/yellow.png';

  @override
  String get successThemeAsset => 'assets/images/dashatar/success/yellow.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/yellow_dashatar_off.png';

  @override
  String get audioAsset => 'assets/audio/sandwich.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/dashatar/yellow';
}
