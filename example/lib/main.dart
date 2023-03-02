import 'package:easy_puzzle_game/easy_puzzle_game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const EasyPuzzleGameApp(
      title: 'Puzzle',
      puzzleFullImg:
          'https://github.com/mhanzla80/easy_puzzle_game/raw/master/puzzle.png',
      puzzleBlockFolderPath:
          'https://github.com/mhanzla80/easy_puzzle_game/raw/master/blocks',
    );
  }
}
