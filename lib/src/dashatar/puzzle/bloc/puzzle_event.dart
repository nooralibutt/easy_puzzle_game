// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class MyPuzzleInitialized extends PuzzleEvent {
  const MyPuzzleInitialized({required this.shufflePuzzle});

  final bool shufflePuzzle;

  @override
  List<Object> get props => [shufflePuzzle];
}

class TileTapped extends PuzzleEvent {
  const TileTapped(this.tile);

  final MyTile tile;

  @override
  List<Object> get props => [tile];
}

class PuzzleReset extends PuzzleEvent {
  const PuzzleReset();
}
