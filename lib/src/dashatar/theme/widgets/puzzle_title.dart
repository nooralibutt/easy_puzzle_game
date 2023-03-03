import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:flutter/material.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class PuzzleTitle extends StatelessWidget {
  /// {@macro puzzle_title}
  const PuzzleTitle({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  /// The title to be displayed.
  final String title;

  /// The color of [title], defaults to [PuzzleTheme.titleColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child,
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: child,
      ),
      large: (context, child) => SizedBox(
        width: 300,
        child: child,
      ),
      child: (currentSize) {
        final textAlign = currentSize == ResponsiveLayoutSize.small
            ? TextAlign.center
            : TextAlign.left;

        return AnimatedDefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.bold),
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Text(
            title,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}
