// ignore_for_file: public_member_api_docs

part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class MyTimerStarted extends TimerEvent {
  const MyTimerStarted();
}

class TimerTicked extends TimerEvent {
  const TimerTicked(this.secondsElapsed);

  final int secondsElapsed;

  @override
  List<Object> get props => [secondsElapsed];
}

class MyTimerStopped extends TimerEvent {
  const MyTimerStopped();
}

class MyTimerReset extends TimerEvent {
  const MyTimerReset();
}
