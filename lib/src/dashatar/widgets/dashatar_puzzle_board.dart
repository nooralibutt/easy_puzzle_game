import 'dart:async';

import 'package:easy_puzzle_game/src/dashatar/audio_control/bloc/audio_control_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_theme_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/helpers/modal_helper.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/timer/bloc/timer_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_share_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template dashatar_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class MyDashatarPuzzleBoard extends StatefulWidget {
  /// {@macro dashatar_puzzle_board}
  const MyDashatarPuzzleBoard({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  @override
  State<MyDashatarPuzzleBoard> createState() => _MyDashatarPuzzleBoardState();
}

class _MyDashatarPuzzleBoardState extends State<MyDashatarPuzzleBoard> {
  Timer? _completePuzzleTimer;

  @override
  void dispose() {
    _completePuzzleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyPuzzleBloc, MyPuzzleState>(
      listener: (context, state) async {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          _completePuzzleTimer =
              Timer(const Duration(milliseconds: 370), () async {
            await showAppDialog<void>(
              context: context,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<MyDashatarThemeBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<MyPuzzleBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<MyTimerBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AudioControlBloc>(),
                  ),
                ],
                child: MyDashatarShareDialog(),
              ),
            );
          });
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_board_small'),
          dimension: _BoardSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_board_medium'),
          dimension: _BoardSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_board_large'),
          dimension: _BoardSize.large,
          child: child,
        ),
        child: (_) => Stack(children: widget.tiles),
      ),
    );
  }
}
