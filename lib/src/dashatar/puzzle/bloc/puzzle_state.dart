// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum PuzzleStatus { incomplete, complete }

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class MyPuzzleState extends Equatable {
  const MyPuzzleState({
    this.puzzle = const MyPuzzle(tiles: []),
    this.puzzleStatus = PuzzleStatus.incomplete,
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
    this.numberOfCorrectTiles = 0,
    this.numberOfMoves = 0,
    this.lastTappedTile,
  });

  /// [MyPuzzle] containing the current tile arrangement.
  final MyPuzzle puzzle;

  /// Status indicating the current state of the puzzle.
  final PuzzleStatus puzzleStatus;

  /// Status indicating if a [MyTile] was moved or why a [MyTile] was not moved.
  final TileMovementStatus tileMovementStatus;

  /// Represents the last tapped tile of the puzzle.
  ///
  /// The value is `null` if the user has not interacted with
  /// the puzzle yet.
  final MyTile? lastTappedTile;

  /// Number of tiles currently in their correct position.
  final int numberOfCorrectTiles;

  /// Number of tiles currently not in their correct position.
  int get numberOfTilesLeft => puzzle.tiles.length - numberOfCorrectTiles - 1;

  /// Number representing how many moves have been made on the current puzzle.
  ///
  /// The number of moves is not always the same as the total number of tiles
  /// moved. If a row/column of 2+ tiles are moved from one tap, one move is
  /// added.
  final int numberOfMoves;

  MyPuzzleState copyWith({
    MyPuzzle? puzzle,
    PuzzleStatus? puzzleStatus,
    TileMovementStatus? tileMovementStatus,
    int? numberOfCorrectTiles,
    int? numberOfMoves,
    MyTile? lastTappedTile,
  }) {
    return MyPuzzleState(
      puzzle: puzzle ?? this.puzzle,
      puzzleStatus: puzzleStatus ?? this.puzzleStatus,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
      numberOfCorrectTiles: numberOfCorrectTiles ?? this.numberOfCorrectTiles,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      lastTappedTile: lastTappedTile ?? this.lastTappedTile,
    );
  }

  @override
  List<Object?> get props => [
        puzzle,
        puzzleStatus,
        tileMovementStatus,
        numberOfCorrectTiles,
        numberOfMoves,
        lastTappedTile,
      ];
}
