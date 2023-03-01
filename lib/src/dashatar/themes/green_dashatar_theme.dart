import 'package:easy_puzzle_game/src/dashatar/colors/colors.dart';
import 'package:easy_puzzle_game/src/dashatar/themes/dashatar_theme.dart';
import 'package:flutter/material.dart';

/// {@template green_dashatar_theme}
/// The green dashatar puzzle theme.
/// {@endtemplate}
class MyGreenDashatarTheme extends MyDashatarTheme {
  /// {@macro green_dashatar_theme}
  const MyGreenDashatarTheme() : super();

  @override
  String semanticsLabel(BuildContext context) => '';

  @override
  Color get backgroundColor => PuzzleColors.greenPrimary;

  @override
  Color get defaultColor => PuzzleColors.green90;

  @override
  Color get buttonColor => PuzzleColors.green50;

  @override
  Color get menuInactiveColor => PuzzleColors.green50;

  @override
  Color get countdownColor => PuzzleColors.green50;

  @override
  String get themeAsset => 'assets/images/dashatar/gallery/green.png';

  @override
  String get successThemeAsset => 'assets/images/dashatar/success/green.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/green_dashatar_off.png';

  @override
  String get audioAsset => 'assets/audio/skateboard.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/dashatar/green';
}
