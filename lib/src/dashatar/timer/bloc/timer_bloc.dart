// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_puzzle_game/src/models/ticker.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class MyTimerBloc extends Bloc<TimerEvent, MyTimerState> {
  MyTimerBloc({required MyTicker ticker})
      : _ticker = ticker,
        super(const MyTimerState()) {
    on<MyTimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<MyTimerStopped>(_onTimerStopped);
    on<MyTimerReset>(_onTimerReset);
  }

  final MyTicker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTimerStarted(MyTimerStarted event, Emitter<MyTimerState> emit) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick()
        .listen((secondsElapsed) => add(TimerTicked(secondsElapsed)));
    emit(state.copyWith(isRunning: true));
  }

  void _onTimerTicked(TimerTicked event, Emitter<MyTimerState> emit) {
    emit(state.copyWith(secondsElapsed: event.secondsElapsed));
  }

  void _onTimerStopped(MyTimerStopped event, Emitter<MyTimerState> emit) {
    _tickerSubscription?.pause();
    emit(state.copyWith(isRunning: false));
  }

  void _onTimerReset(MyTimerReset event, Emitter<MyTimerState> emit) {
    _tickerSubscription?.cancel();
    emit(state.copyWith(secondsElapsed: 0));
  }
}
