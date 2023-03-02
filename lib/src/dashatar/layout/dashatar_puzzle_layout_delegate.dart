import 'package:easy_puzzle_game/src/dashatar/layout/puzzle_layout_delegate.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_gap.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/bloc/puzzle_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_countdown.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_puzzle_action_button.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_puzzle_board.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_puzzle_tile.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_start_section.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_theme_picker.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_timer.dart';
import 'package:easy_puzzle_game/src/models/tile.dart';
import 'package:flutter/material.dart';

/// {@template dashatar_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [MyDashatarTheme].
/// {@endtemplate}
class MyDashatarPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro dashatar_puzzle_layout_delegate}
  const MyDashatarPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(MyPuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => MyDashatarStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(MyPuzzleState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ResponsiveGap(
          small: 23,
          medium: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const MyDashatarPuzzleActionButton(),
          medium: (_, child) => const MyDashatarPuzzleActionButton(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const MyDashatarThemePicker(),
          medium: (_, child) => const MyDashatarThemePicker(),
          large: (_, child) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        const ResponsiveGap(
          large: 130,
        ),
        const MyDashatarCountdown(),
      ],
    );
  }

  @override
  Widget backgroundBuilder(MyPuzzleState state) {
    return Positioned(
      bottom: 74,
      right: 50,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => const SizedBox(),
        medium: (_, child) => const SizedBox(),
        large: (_, child) => const MyDashatarThemePicker(),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Stack(
      children: [
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: ResponsiveLayoutBuilder(
            small: (_, child) => const SizedBox(),
            medium: (_, child) => const SizedBox(),
            large: (_, child) => const MyDashatarTimer(),
          ),
        ),
        Column(
          children: [
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
            ),
            MyDashatarPuzzleBoard(tiles: tiles),
            const ResponsiveGap(
              large: 96,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(MyTile tile, MyPuzzleState state) {
    return MyDashatarPuzzleTile(
      tile: tile,
      state: state,
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
