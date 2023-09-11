import 'package:easy_puzzle_game/src/dashatar/my_audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/puzzle.dart';
import 'package:easy_puzzle_game/src/easy_puzzle_game_controller.dart';
import 'package:flutter/material.dart';

class EasyPuzzleGameApp extends StatelessWidget {
  const EasyPuzzleGameApp({
    Key? key,
    this.title,
    required this.puzzleFullImg,
    this.puzzleRowColumn = 3,
  }) : super(key: key);

  /// This is the main title text
  final String? title;

  /// This is the full and complete puzzle image
  final String puzzleFullImg;

  /// This is the path of puzzle folder in which all puzzle block images with numbering are present

  /// This is the puzzle difficulty
  final int puzzleRowColumn;

  @override
  Widget build(BuildContext context) {
    return EasyPuzzleGameController(
      title: title,
      puzzleFullImg: puzzleFullImg,
      puzzleRowColumn: puzzleRowColumn,
      parentContext: context,
      child: Builder(
        builder: (context) {
          return MyPuzzlePage(
              controller: EasyPuzzleGameController.of(context));
        }
      ),
    );
  }

}
