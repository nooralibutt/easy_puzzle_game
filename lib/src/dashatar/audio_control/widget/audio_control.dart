import 'package:easy_puzzle_game/src/dashatar/audio_control/bloc/audio_control_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/bloc/theme_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/themes/puzzle_theme_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template audio_control}
/// Displays and allows to update the current audio status of the puzzle.
/// {@endtemplate}
class AudioControl extends StatelessWidget {
  /// {@macro audio_control}
  const AudioControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final audioMuted =
        context.select((AudioControlBloc bloc) => bloc.state.muted);
    final audioAsset =
        audioMuted ? theme.audioControlOffAsset : theme.audioControlOnAsset;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<AudioControlBloc>().add(AudioToggled()),
        child: AnimatedSwitcher(
          duration: PuzzleThemeAnimationDuration.backgroundColorChange,
          child: ResponsiveLayoutBuilder(
            key: Key(audioAsset),
            small: (_, __) => Image.asset(
              audioAsset,
              key: const Key('audio_control_small'),
              width: 24,
              height: 24,
            ),
            medium: (_, __) => Image.asset(
              audioAsset,
              key: const Key('audio_control_medium'),
              width: 33,
              height: 33,
            ),
            large: (_, __) => Image.asset(
              audioAsset,
              key: const Key('audio_control_large'),
              width: 33,
              height: 33,
            ),
          ),
        ),
      ),
    );
  }
}
