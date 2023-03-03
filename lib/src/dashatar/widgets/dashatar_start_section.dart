import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_gap.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/view/puzzle_page.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/widgets/number_of_moves_and_tiles_left.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/widgets/puzzle_name.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/widgets/puzzle_title.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_puzzle_action_button.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_timer.dart';
import 'package:easy_puzzle_game/src/easy_puzzle_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template dashatar_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class MyDashatarStartSection extends StatelessWidget {
  /// {@macro dashatar_start_section}
  const MyDashatarStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final MyPuzzleState state;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((MyDashatarPuzzleBloc bloc) => bloc.state.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        PuzzleName(
          key: puzzleNameKey,
        ),
        if (EasyPuzzleGameController.of(context).title != null)
          const ResponsiveGap(large: 16),
        if (EasyPuzzleGameController.of(context).title != null)
          PuzzleTitle(
            key: puzzleTitleKey,
            title: EasyPuzzleGameController.of(context).title!,
          ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: status == DashatarPuzzleStatus.started
              ? state.numberOfTilesLeft
              : state.puzzle.tiles.length - 1,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const MyDashatarPuzzleActionButton(),
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const MyDashatarTimer(),
          medium: (_, __) => const MyDashatarTimer(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
