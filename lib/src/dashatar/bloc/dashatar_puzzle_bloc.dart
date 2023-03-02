import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_puzzle_game/src/models/ticker.dart';
import 'package:equatable/equatable.dart';

part 'dashatar_puzzle_event.dart';
part 'dashatar_puzzle_state.dart';

/// {@template dashatar_puzzle_bloc}
/// A bloc responsible for starting the Dashatar puzzle.
/// {@endtemplate}
class MyDashatarPuzzleBloc
    extends Bloc<MyDashatarPuzzleEvent, MyDashatarPuzzleState> {
  /// {@macro dashatar_puzzle_bloc}
  MyDashatarPuzzleBloc({
    required this.secondsToBegin,
    required MyTicker ticker,
  })  : _ticker = ticker,
        super(MyDashatarPuzzleState(secondsToBegin: secondsToBegin)) {
    on<MyDashatarCountdownStarted>(_onCountdownStarted);
    on<MyDashatarCountdownTicked>(_onCountdownTicked);
    on<MyDashatarCountdownStopped>(_onCountdownStopped);
    on<MyDashatarCountdownReset>(_onCountdownReset);
  }

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final MyTicker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const MyDashatarCountdownTicked()));
  }

  void _onCountdownStarted(
    MyDashatarCountdownStarted event,
    Emitter<MyDashatarPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    MyDashatarCountdownTicked event,
    Emitter<MyDashatarPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    MyDashatarCountdownStopped event,
    Emitter<MyDashatarPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    MyDashatarCountdownReset event,
    Emitter<MyDashatarPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
      ),
    );
  }
}
