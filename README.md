# Easy Puzzle Game

## Features
- Support for Puzzles
- Support for Puzzles asset and network images

## How to use

* A 3x3 puzzle board visualization:
```
┌─────1───────2───────3────► x
│  ┌─────┐ ┌─────┐ ┌─────┐
1  │  1  │ │  2  │ │  3  │
│  └─────┘ └─────┘ └─────┘
│  ┌─────┐ ┌─────┐ ┌─────┐
2  │  4  │ │  5  │ │  6  │
│  └─────┘ └─────┘ └─────┘
│  ┌─────┐ ┌─────┐
3  │  7  │ │  8  │
│  └─────┘ └─────┘
▼
  y
```

```dart
await const EasyPuzzleGameApp(
      title: 'Puzzle',
    /// this is the puzzle full image
      puzzleFullImg:
          'https://github.com/mhanzla80/easy_puzzle_game/raw/master/puzzle.png',
    /// this is the puzzle block images, you have to pass the folder path in which images are present.
    /// if rows and columns are 3 the 3x3=9
    /// if rows and columns are 4 the 4x4=9
      puzzleBlockFolderPath:
          'https://github.com/mhanzla80/easy_puzzle_game/raw/master/blocks',
    /// this is the number of puzzle rows and columns.
      puzzleRowColumn: 4,
    );
);
```

## Authors
##### Noor Ali Butt
[![GitHub Follow](https://img.shields.io/badge/Connect--blue.svg?logo=Github&longCache=true&style=social&label=Follow)](https://github.com/nooralibutt) [![LinkedIn Link](https://img.shields.io/badge/Connect--blue.svg?logo=linkedin&longCache=true&style=social&label=Connect
)](https://www.linkedin.com/in/nooralibutt)
##### Hanzla Waheed
[![GitHub Follow](https://img.shields.io/badge/Connect--blue.svg?logo=Github&longCache=true&style=social&label=Follow)](https://github.com/mhanzla80) [![LinkedIn Link](https://img.shields.io/badge/Connect--blue.svg?logo=linkedin&longCache=true&style=social&label=Connect
)](https://www.linkedin.com/in/mhanzla80)