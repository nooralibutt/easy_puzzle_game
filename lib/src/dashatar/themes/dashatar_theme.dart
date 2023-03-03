import 'package:easy_puzzle_game/src/dashatar/layout/dashatar_puzzle_layout_delegate.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/puzzle_layout_delegate.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme.dart';
import 'package:easy_puzzle_game/src/models/tile.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

/// {@template dashatar_theme}
/// The dashatar puzzle theme.
/// {@endtemplate}
abstract class MyDashatarTheme extends PuzzleTheme {
  /// {@macro dashatar_theme}
  const MyDashatarTheme() : super();

  @override
  String get name => 'Dashatar';

  @override
  String get audioControlOnAsset =>
      'assets/images/audio_control/dashatar_on.png';

  @override
  bool get hasTimer => true;

  @override
  bool get isLogoColored => false;

  @override
  PuzzleLayoutDelegate get layoutDelegate =>
      const MyDashatarPuzzleLayoutDelegate();

  /// The semantics label of this theme.
  String semanticsLabel(BuildContext context);

  /// The text color of the countdown timer.
  Color get countdownColor;

  /// The path to the image asset of this theme.
  ///
  /// This asset is shown in the Dashatar theme picker.
  String get themeAsset;

  /// The path to the success image asset of this theme.
  ///
  /// This asset is shown in the success state of the Dashatar puzzle.
  String get successThemeAsset;

  /// The path to the audio asset of this theme.
  String get audioAsset;

  /// The path to the directory with dash assets for all puzzle tiles.
  String get dashAssetsDirectory;

  /// The path to the dash asset for the given [tile].
  ///
  /// The puzzle consists of 15 Dash tiles which correct board positions
  /// are as follows:
  ///
  ///  1   2   3   4
  ///  5   6   7   8
  ///  9  10  11  12
  /// 13  14  15
  ///
  /// The dash asset for the i-th tile may be found in the file i.png.
  String dashAssetForTile(MyTile tile) =>
      p.join(dashAssetsDirectory, '${tile.value.toString()}.png');

  @override
  List<Object?> get props => [
        name,
        hasTimer,
        nameColor,
        titleColor,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        isLogoColored,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        audioControlOnAsset,
        audioControlOffAsset,
        layoutDelegate,
        countdownColor,
        themeAsset,
        successThemeAsset,
        audioAsset,
        dashAssetsDirectory
      ];
}
