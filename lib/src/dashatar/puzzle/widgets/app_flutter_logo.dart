import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:flutter/material.dart';

/// {@template app_flutter_logo}
/// Variant of Flutter logo that can be either white or colored.
/// {@endtemplate}
class AppFlutterLogo extends StatelessWidget {
  /// {@macro app_flutter_logo}
  const AppFlutterLogo({
    Key? key,
    this.isColored = true,
    this.height,
  }) : super(key: key);

  /// Whether this logo is colored.
  final bool isColored;

  /// The optional height of this logo.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final assetName = isColored ? 'assets/icon.png' : 'assets/icon.png';

    return AnimatedSwitcher(
      duration: PuzzleThemeAnimationDuration.logoChange,
      child: height != null
          ? Image.asset(
              assetName,
              height: height,
            )
          : ResponsiveLayoutBuilder(
              key: Key(assetName),
              small: (_, __) => const SizedBox(),
              medium: (_, __) => Image.asset(
                assetName,
                height: 29,
              ),
              large: (_, __) => Image.asset(
                assetName,
                height: 32,
              ),
            ),
    );
  }
}
