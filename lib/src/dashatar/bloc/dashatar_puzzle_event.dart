// ignore_for_file: public_member_api_docs

part of 'dashatar_puzzle_bloc.dart';

abstract class MyDashatarPuzzleEvent extends Equatable {
  const MyDashatarPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class MyDashatarCountdownStarted extends MyDashatarPuzzleEvent {
  const MyDashatarCountdownStarted();
}

class MyDashatarCountdownTicked extends MyDashatarPuzzleEvent {
  const MyDashatarCountdownTicked();
}

class MyDashatarCountdownStopped extends MyDashatarPuzzleEvent {
  const MyDashatarCountdownStopped();
}

class MyDashatarCountdownReset extends MyDashatarPuzzleEvent {
  const MyDashatarCountdownReset({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [MyDashatarPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}
