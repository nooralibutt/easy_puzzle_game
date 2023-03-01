import 'package:easy_puzzle_game/src/dashatar/my_audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/puzzle/puzzle.dart';
import 'package:flutter/material.dart';

class EasyPuzzleGameApp extends StatelessWidget {
  const EasyPuzzleGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyPuzzlePage();
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
