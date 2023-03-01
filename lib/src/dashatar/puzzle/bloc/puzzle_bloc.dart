// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_puzzle_game/src/models/position.dart';
import 'package:easy_puzzle_game/src/models/puzzle.dart';
import 'package:easy_puzzle_game/src/models/tile.dart';
import 'package:equatable/equatable.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class MyPuzzleBloc extends Bloc<PuzzleEvent, MyPuzzleState> {
  MyPuzzleBloc(this._size, {this.random}) : super(const MyPuzzleState()) {
    on<MyPuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
  }

  final int _size;

  final Random? random;

  void _onPuzzleInitialized(
    MyPuzzleInitialized event,
    Emitter<MyPuzzleState> emit,
  ) {
    final puzzle = _generatePuzzle(_size, shuffle: event.shufflePuzzle);
    emit(
      MyPuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  void _onTileTapped(TileTapped event, Emitter<MyPuzzleState> emit) {
    final tappedTile = event.tile;
    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = MyPuzzle(tiles: [...state.puzzle.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
        if (puzzle.isComplete()) {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        } else {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter<MyPuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    emit(
      MyPuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  /// Build a randomized, solvable puzzle of the given size.
  MyPuzzle _generatePuzzle(int size, {bool shuffle = true}) {
    final correctPositions = <MyPosition>[];
    final currentPositions = <MyPosition>[];
    final whitespacePosition = MyPosition(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = MyPosition(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile posistions.
      currentPositions.shuffle(random);
    }

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
    );

    var puzzle = MyPuzzle(tiles: tiles);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle(random);
        tiles = _getTileListFromPositions(
          size,
          correctPositions,
          currentPositions,
        );
        puzzle = MyPuzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<MyTile> _getTileListFromPositions(
    int size,
    List<MyPosition> correctPositions,
    List<MyPosition> currentPositions,
  ) {
    final whitespacePosition = MyPosition(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          MyTile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          MyTile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }
}
