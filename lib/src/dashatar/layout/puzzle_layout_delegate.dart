import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/models/tile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI.
/// {@endtemplate}
abstract class PuzzleLayoutDelegate extends Equatable {
  /// {@macro puzzle_layout_delegate}
  const PuzzleLayoutDelegate();

  /// A widget builder for the start section of the puzzle based on
  /// the puzzle [state].
  ///
  /// This section corresponds to:
  /// - the left side of the puzzle UI (to the left of the puzzle board)
  /// on a desktop.
  /// - the top side of the puzzle UI (above the puzzle board)
  /// on a tablet/mobile.
  Widget startSectionBuilder(MyPuzzleState state);

  /// A widget builder for the end section of the puzzle based on
  /// the puzzle [state].
  ///
  /// This section corresponds to:
  /// - the right side of the puzzle UI (to the right of the puzzle board)
  /// on a desktop.
  /// - the bottom side of the puzzle UI (below the puzzle board)
  /// on a tablet/mobile.
  Widget endSectionBuilder(MyPuzzleState state);

  /// A widget builder for the background of the puzzle based on
  /// the puzzle [state].
  Widget backgroundBuilder(MyPuzzleState state);

  /// A widget builder for the puzzle board.
  ///
  /// The board should have a dimension of [size]
  /// (e.g. 4x4 puzzle has a dimension of 4).
  ///
  /// The board should display the list of [tiles],
  /// each built with [tileBuilder].
  Widget boardBuilder(int size, List<Widget> tiles);

  /// A widget builder for the puzzle tile associated
  /// with [tile] and based on the puzzle [state].
  ///
  /// To complete the puzzle, all tiles must be arranged
  /// in order by their [MyTile.value].
  Widget tileBuilder(MyTile tile, MyPuzzleState state);

  /// A widget builder for the whitespace puzzle tile.
  Widget whitespaceTileBuilder();
}
