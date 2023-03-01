import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/bloc/theme_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:easy_puzzle_game/src/dashatar/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template puzzle_name}
/// Displays the name of the current puzzle theme.
/// Visible only on a large layout.
/// {@endtemplate}
class PuzzleName extends StatelessWidget {
  /// {@macro puzzle_name}
  const PuzzleName({
    Key? key,
    this.color,
  }) : super(key: key);

  /// The color of this name, defaults to [PuzzleTheme.nameColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final nameColor = color ?? theme.nameColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => const SizedBox(),
      medium: (context, child) => const SizedBox(),
      large: (context, child) => AnimatedDefaultTextStyle(
        style: PuzzleTextStyle.headline5.copyWith(
          color: nameColor,
        ),
        duration: PuzzleThemeAnimationDuration.textStyle,
        child: Text(
          theme.name,
          key: const Key('puzzle_name_theme'),
        ),
      ),
    );
  }
}
