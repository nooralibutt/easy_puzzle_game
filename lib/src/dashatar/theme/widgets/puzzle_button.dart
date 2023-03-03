import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/widgets/animated_text_button.dart';
import 'package:flutter/material.dart';

/// {@template puzzle_button}
/// Displays the puzzle action button.
/// {@endtemplate}
class PuzzleButton extends StatelessWidget {
  /// {@macro puzzle_button}
  const PuzzleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  /// The background color of this button.
  /// Defaults to [PuzzleTheme.buttonColor].
  final Color? backgroundColor;

  /// The text color of this button.
  /// Defaults to [PuzzleColors.white].
  final Color? textColor;

  /// Called when this button is tapped.
  final VoidCallback? onPressed;

  /// The label of this button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 145,
      height: 44,
      child: AnimatedTextButton(
        duration: PuzzleThemeAnimationDuration.textStyle,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ).copyWith(
          backgroundColor: MaterialStateProperty.all(theme.primaryColor),
          foregroundColor:
              MaterialStateProperty.all(theme.secondaryHeaderColor),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
