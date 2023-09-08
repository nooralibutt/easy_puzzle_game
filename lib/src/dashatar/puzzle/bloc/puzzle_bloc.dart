// ignore_for_file: public_member_api_docs

import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:easy_puzzle_game/src/easy_puzzle_game_controller.dart';
import 'package:easy_puzzle_game/src/models/position.dart';
import 'package:easy_puzzle_game/src/models/puzzle.dart';
import 'package:easy_puzzle_game/src/models/tile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class MyPuzzleBloc extends Bloc<PuzzleEvent, MyPuzzleState> {
  MyPuzzleBloc(this.context, {this.random}) : super(const MyPuzzleState()) {
    on<MyPuzzleInitialized>((event,emit) async {
      await _onPuzzleInitialized(event, emit);
    });
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
  }

  final BuildContext context;

  final Random? random;
  late List<Uint8List?> images ;


  Future<void> _onPuzzleInitialized(
    MyPuzzleInitialized event,
    Emitter<MyPuzzleState> emit,
  ) async{
    images = await cropImage();

    final puzzle = _generatePuzzle(
        EasyPuzzleGameController.of(context).puzzleRowColumn,
        shuffle: event.shufflePuzzle);
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
    final puzzle =
        _generatePuzzle(EasyPuzzleGameController.of(context).puzzleRowColumn);
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
  Future<List<Uint8List>> cropImage() async{
    final String image = EasyPuzzleGameController.of(context).puzzleFullImg;
    final int count = EasyPuzzleGameController.of(context).puzzleRowColumn;

    final List<Uint8List> images = [];
    final data = await rootBundle.load(image);

    final buffer = await ui.ImmutableBuffer.fromUint8List(
        data.buffer.asUint8List());

    final id = await ui.ImageDescriptor.encoded(buffer);
    final codec = await id.instantiateCodec(
        targetHeight: id.height,
        targetWidth: id.width);

    final fi = await codec.getNextFrame();

    final uiImage = fi.image;
    final uiBytes = await uiImage.toByteData();

    final assetImage = img.Image.fromBytes(width: id.width, height: id.height,
        bytes: uiBytes!.buffer, numChannels: 4);



    try{
      for(int i = 0; i < count ; i++){
        for(int j = 0 ; j < count ; j++){

          if(j ==  count - 1 && i == count - 1){

          }else{
            final int cropSquareSize = (assetImage.width + assetImage.height) ~/ (count  + count);
            final newCommand = img.copyCrop(assetImage,x: j * cropSquareSize, y: i * cropSquareSize, width: cropSquareSize, height: cropSquareSize);
            images.add(img.encodeJpg(newCommand));
          }

          print("images.length");
          print(images.length);



        }
      }
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return images;
  }
  List<MyTile> _getTileListFromPositions(
    int size,
    List<MyPosition> correctPositions,
    List<MyPosition> currentPositions,
  ) {
    final whitespacePosition = MyPosition(x: size, y: size);
    return [
      for (int i = 0; i < size * size; i++)
        if (i == (size * size) - 1)
          MyTile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i],
            isWhitespace: true,

          )
        else
          MyTile(
            value: i,
            correctPosition: correctPositions[i ],
            image: images[i],
            currentPosition: currentPositions[i ],
          )
    ];
  }
}
