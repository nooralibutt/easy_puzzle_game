import 'package:easy_puzzle_game/src/dashatar/audio_control/widget/audio_control_listener.dart';
import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/helpers/audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/my_audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/theme/widgets/puzzle_button.dart';
import 'package:easy_puzzle_game/src/dashatar/timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template dashatar_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class MyDashatarPuzzleActionButton extends StatefulWidget {
  /// {@macro dashatar_puzzle_action_button}
  const MyDashatarPuzzleActionButton(
      {Key? key, AudioPlayerFactory? audioPlayer})
      : super(key: key);

  @override
  State<MyDashatarPuzzleActionButton> createState() =>
      _MyDashatarPuzzleActionButtonState();
}

class _MyDashatarPuzzleActionButtonState
    extends State<MyDashatarPuzzleActionButton> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((MyDashatarPuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == DashatarPuzzleStatus.loading;
    final isStarted = status == DashatarPuzzleStatus.started;

    final text =
        isStarted ? 'Restart' : (isLoading ? 'GetReady..' : 'Start Game');

    return AudioControlListener(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(status),
          message: isStarted ? 'Start Game' : '',
          verticalOffset: 40,
          child: PuzzleButton(
            onPressed: isLoading
                ? null
                : () async {
                    //Todo: EasyServicesManager.instance.showCountedInterstitialAd();
                    final hasStarted = status == DashatarPuzzleStatus.started;

                    // Reset the timer and the countdown.
                    context.read<MyTimerBloc>().add(const MyTimerReset());
                    context.read<MyDashatarPuzzleBloc>().add(
                          MyDashatarCountdownReset(
                            secondsToBegin: hasStarted ? 5 : 3,
                          ),
                        );

                    // Initialize the puzzle board to show the initial puzzle
                    // (unshuffled) before the countdown completes.
                    if (hasStarted) {
                      context.read<MyPuzzleBloc>().add(
                            const MyPuzzleInitialized(shufflePuzzle: false),
                          );
                    }

                    MyAudioPlayer.instance.playClick();
                  },
            textColor: isLoading ? Theme.of(context).primaryColorDark : null,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
