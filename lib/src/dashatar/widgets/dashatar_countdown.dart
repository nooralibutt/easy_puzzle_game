import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/helpers/audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/timer/bloc/timer_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template dashatar_countdown}
/// Displays the countdown before the puzzle is started.
/// {@endtemplate}
class MyDashatarCountdown extends StatefulWidget {
  /// {@macro dashatar_countdown}
  const MyDashatarCountdown({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDashatarCountdown> createState() => _MyDashatarCountdownState();
}

class _MyDashatarCountdownState extends State<MyDashatarCountdown> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyDashatarPuzzleBloc, MyDashatarPuzzleState>(
      listener: (context, state) {
        if (!state.isCountdownRunning) {
          return;
        }


        // Start the puzzle timer when the countdown finishes.
        if (state.status == DashatarPuzzleStatus.started) {
          context.read<MyTimerBloc>().add(const MyTimerStarted());
        }

        // Shuffle the puzzle on every countdown tick.
        if (state.secondsToBegin >= 1 && state.secondsToBegin <= 3) {
          context.read<MyPuzzleBloc>().add(const PuzzleReset());
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, __) => const SizedBox(),
        medium: (_, __) => const SizedBox(),
        large: (_, __) =>
            BlocBuilder<MyDashatarPuzzleBloc, MyDashatarPuzzleState>(
              builder: (context, state) {
                if (!state.isCountdownRunning || state.secondsToBegin > 3) {
                  return const SizedBox();
                }

                if (state.secondsToBegin > 0) {
                  return DashatarCountdownSecondsToBegin(
                    key: ValueKey(state.secondsToBegin),
                    secondsToBegin: state.secondsToBegin,
                  );
                } else {
                  return const MyDashatarCountdownGo();
                }
              },
            ),
      ),
    );
  }
}

/// {@template dashatar_countdown_seconds_to_begin}
/// Display how many seconds are left to begin the puzzle.
/// {@endtemplate}
@visibleForTesting
class DashatarCountdownSecondsToBegin extends StatefulWidget {
  /// {@macro dashatar_countdown_seconds_to_begin}
  const DashatarCountdownSecondsToBegin({
    Key? key,
    required this.secondsToBegin,
  }) : super(key: key);

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  @override
  State<DashatarCountdownSecondsToBegin> createState() =>
      _MyDashatarCountdownSecondsToBeginState();
}

class _MyDashatarCountdownSecondsToBeginState
    extends State<DashatarCountdownSecondsToBegin>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.81, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: outOpacity,
      child: FadeTransition(
        opacity: inOpacity,
        child: ScaleTransition(
          scale: inScale,
          child: Text(widget.secondsToBegin.toString(),
              style: PuzzleTextStyle.countdownTime),
        ),
      ),
    );
  }
}

/// {@template dashatar_countdown_go}
/// Displays a "Go!" text when the countdown reaches 0 seconds.
/// {@endtemplate}
@visibleForTesting
class MyDashatarCountdownGo extends StatefulWidget {
  /// {@macro dashatar_countdown_go}
  const MyDashatarCountdownGo({Key? key}) : super(key: key);

  @override
  State<MyDashatarCountdownGo> createState() => _MyDashatarCountdownGoState();
}

class _MyDashatarCountdownGoState extends State<MyDashatarCountdownGo>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    outScale = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 101),
      child: FadeTransition(
        opacity: outOpacity,
        child: FadeTransition(
          opacity: inOpacity,
          child: ScaleTransition(
            scale: outScale,
            child: ScaleTransition(
              scale: inScale,
              child: Text(
                'puzzle',
                style: PuzzleTextStyle.countdownTime.copyWith(
                  fontSize: 100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
