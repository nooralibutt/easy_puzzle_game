import 'package:flutter/material.dart';

class EasyPuzzleGameController extends InheritedWidget {
  const EasyPuzzleGameController({
    super.key,
    required this.title,
    required super.child,
    required this.puzzleFullImg,
    required this.puzzleRowColumn,
    required this.puzzleBlockFolderPath,
    required this.parentContext,
  });

  /// This is the main title text
  final String title;

  /// This is the full and complete puzzle image
  final String puzzleFullImg;

  /// This is the path of puzzle folder in which all puzzle block images with numbering are present
  final String puzzleBlockFolderPath;

  /// This is the puzzle difficulty
  final int puzzleRowColumn;

  final BuildContext parentContext;

  static EasyPuzzleGameController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<EasyPuzzleGameController>();
  }

  static EasyPuzzleGameController of(BuildContext context) {
    final EasyPuzzleGameController? result = maybeOf(context);
    assert(result != null, 'No controller found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(EasyPuzzleGameController oldWidget) =>
      title != oldWidget.title;
}
