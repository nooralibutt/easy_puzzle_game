import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:easy_puzzle_game/src/dashatar/timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// {@template dashatar_timer}
/// Displays how many seconds elapsed since starting the puzzle.
/// {@endtemplate}
class MyDashatarTimer extends StatelessWidget {
  /// {@macro dashatar_timer}
  const MyDashatarTimer({
    Key? key,
    this.textStyle,
    this.iconSize,
    this.iconPadding,
    this.mainAxisAlignment,
  }) : super(key: key);

  /// The optional [TextStyle] of this timer.
  final TextStyle? textStyle;

  /// The optional icon [Size] of this timer.
  final Size? iconSize;

  /// The optional icon padding of this timer.
  final double? iconPadding;

  /// The optional [MainAxisAlignment] of this timer.
  /// Defaults to [MainAxisAlignment.center] if not provided.
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final secondsElapsed =
        context.select((MyTimerBloc bloc) => bloc.state.secondsElapsed);

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final currentIconSize = iconSize ??
            (currentSize == ResponsiveLayoutSize.small
                ? const Size(28, 28)
                : const Size(32, 32));

        final timeElapsed = Duration(seconds: secondsElapsed);

        return Row(
          key: const Key('dashatar_timer'),
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              style: Theme.of(context).textTheme.headlineSmall!,
              duration: PuzzleThemeAnimationDuration.textStyle,
              child: Text(
                _formatDuration(timeElapsed),
                key: ValueKey(secondsElapsed),
                semanticsLabel: _getDurationLabel(timeElapsed, context),
              ),
            ),
            Gap(iconPadding ?? 8),
            Icon(
              key: const Key('dashatar_timer_icon'),
              Icons.timer,
              size: currentIconSize.width,
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String _getDurationLabel(Duration duration, BuildContext context) {
    return 'Moves';
  }
}
