import 'dart:async';

import 'package:easy_puzzle_game/src/dashatar/audio_control/widget/audio_control_listener.dart';
import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_theme_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/helpers/audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/my_audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:easy_puzzle_game/src/models/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class _TileSize {
  static double small = 75;
  static double medium = 100;
  static double large = 112;
}

/// {@template dashatar_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class MyDashatarPuzzleTile extends StatefulWidget {
  /// {@macro dashatar_puzzle_tile}
  const MyDashatarPuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  /// The tile to be displayed.
  final MyTile tile;

  /// The state of the puzzle.
  final MyPuzzleState state;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<MyDashatarPuzzleTile> createState() => MyDashatarPuzzleTileState();
}

/// The state of [MyDashatarPuzzleTile].
@visibleForTesting
class MyDashatarPuzzleTileState extends State<MyDashatarPuzzleTile>
    with SingleTickerProviderStateMixin {
  late final Timer _timer;

  /// The controller that drives [_scale] animation.
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.puzzleTileScale,
    );

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );

    // Delay the initialization of the audio player for performance reasons,
    // to avoid dropping frames when the theme is changed.
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    final theme =
        context.select((MyDashatarThemeBloc bloc) => bloc.state.theme);
    final status =
        context.select((MyDashatarPuzzleBloc bloc) => bloc.state.status);
    final hasStarted = status == DashatarPuzzleStatus.started;
    final puzzleIncomplete =
        context.select((MyPuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.incomplete;

    final movementDuration = status == DashatarPuzzleStatus.loading
        ? const Duration(milliseconds: 800)
        : const Duration(milliseconds: 370);

    final canPress = hasStarted && puzzleIncomplete;

    return AudioControlListener(
      child: AnimatedAlign(
        alignment: FractionalOffset(
          (widget.tile.currentPosition.x - 1) / (size - 1),
          (widget.tile.currentPosition.y - 1) / (size - 1),
        ),
        duration: movementDuration,
        curve: Curves.easeInOut,
        child: ResponsiveLayoutBuilder(
          small: (_, child) => SizedBox.square(
            key: Key('dashatar_puzzle_tile_small_${widget.tile.value}'),
            dimension: _TileSize.small,
            child: child,
          ),
          medium: (_, child) => SizedBox.square(
            key: Key('dashatar_puzzle_tile_medium_${widget.tile.value}'),
            dimension: _TileSize.medium,
            child: child,
          ),
          large: (_, child) => SizedBox.square(
            key: Key('dashatar_puzzle_tile_large_${widget.tile.value}'),
            dimension: _TileSize.large,
            child: child,
          ),
          child: (_) => MouseRegion(
            onEnter: (_) {
              if (canPress) {
                _controller.forward();
              }
            },
            onExit: (_) {
              if (canPress) {
                _controller.reverse();
              }
            },
            child: ScaleTransition(
              key: Key('dashatar_puzzle_tile_scale_${widget.tile.value}'),
              scale: _scale,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: canPress
                    ? () {
                        context
                            .read<MyPuzzleBloc>()
                            .add(TileTapped(widget.tile));
                        MyAudioPlayer.instance.playTileMove();
                      }
                    : null,
                icon: Image.asset(
                  theme.dashAssetForTile(widget.tile),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
