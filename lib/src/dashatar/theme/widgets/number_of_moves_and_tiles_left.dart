import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:flutter/material.dart';

/// {@template number_of_moves_and_tiles_left}
/// Displays how many moves have been made on the current puzzle
/// and how many puzzle tiles are not in their correct position.
/// {@endtemplate}
class NumberOfMovesAndTilesLeft extends StatelessWidget {
  /// {@macro number_of_moves_and_tiles_left}
  const NumberOfMovesAndTilesLeft({
    Key? key,
    required this.numberOfMoves,
    required this.numberOfTilesLeft,
    this.color,
  }) : super(key: key);

  /// The number of moves to be displayed.
  final int numberOfMoves;

  /// The number of tiles left to be displayed.
  final int numberOfTilesLeft;

  /// The color of texts that display [numberOfMoves] and [numberOfTilesLeft].
  /// Defaults to [PuzzleTheme.defaultColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      large: (context, child) => child!,
      child: (currentSize) {
        final mainAxisAlignment = currentSize == ResponsiveLayoutSize.large
            ? MainAxisAlignment.start
            : MainAxisAlignment.center;

        return Semantics(
          label: 'Puzzle challenge',
          child: ExcludeSemantics(
            child: Row(
              key: const Key('number_of_moves_and_tiles_left'),
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                AnimatedDefaultTextStyle(
                  key: const Key('number_of_moves_and_tiles_left_moves'),
                  style: Theme.of(context).textTheme.headlineSmall!,
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: Text(numberOfMoves.toString()),
                ),
                AnimatedDefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineSmall!,
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: const Text(' Moves'),
                ),
                AnimatedDefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineSmall!,
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: const Text(' | '),
                ),
                AnimatedDefaultTextStyle(
                  key: const Key('number_of_moves_and_tiles_left_tiles_left'),
                  style: Theme.of(context).textTheme.headlineSmall!,
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: Text('${numberOfTilesLeft.toString()} '),
                ),
                AnimatedDefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineSmall!,
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: const Text('Tiles'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
