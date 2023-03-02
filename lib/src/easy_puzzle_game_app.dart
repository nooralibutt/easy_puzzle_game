import 'package:easy_puzzle_game/src/dashatar/my_audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/puzzle.dart';
import 'package:easy_puzzle_game/src/easy_puzzle_game_controller.dart';
import 'package:flutter/material.dart';

class EasyPuzzleGameApp extends StatelessWidget {
  const EasyPuzzleGameApp({
    Key? key,
    required this.title,
    required this.puzzleFullImg,
    required this.puzzleBlockFolderPath,
  }) : super(key: key);

  /// This is the main title text
  final String title;

  /// This is the full and complete puzzle image
  final String puzzleFullImg;

  /// This is the path of puzzle folder in which all puzzle block images with numbering are present
  final String puzzleBlockFolderPath;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return EasyPuzzleGameController(
              title: title,
              puzzleFullImg: puzzleFullImg,
              puzzleBlockFolderPath: puzzleBlockFolderPath,
              parentContext: context,
              child: const MyPuzzlePage());
        }

        return const Center(child: CircularProgressIndicator.adaptive());
      },
      future: _initialize(),
    );
  }

  Future<void> _initialize() async {
    await MyAudioPlayer.instance.init();
  }
}
