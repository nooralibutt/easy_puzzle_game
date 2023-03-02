// ignore_for_file: public_member_api_docs

part of 'timer_bloc.dart';

class MyTimerState extends Equatable {
  const MyTimerState({
    this.isRunning = false,
    this.secondsElapsed = 0,
  });

  final bool isRunning;
  final int secondsElapsed;

  @override
  List<Object> get props => [isRunning, secondsElapsed];

  MyTimerState copyWith({
    bool? isRunning,
    int? secondsElapsed,
  }) {
    return MyTimerState(
      isRunning: isRunning ?? this.isRunning,
      secondsElapsed: secondsElapsed ?? this.secondsElapsed,
    );
  }
}
