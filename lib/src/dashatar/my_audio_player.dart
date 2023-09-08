// import 'package:just_audio/just_audio.dart';
//
// class MyAudioPlayer {
//   // Singleton instance code
//   static final MyAudioPlayer _instance = MyAudioPlayer._();
//   static MyAudioPlayer get instance => _instance;
//   MyAudioPlayer._();
//   static const assetPrefix = 'lib/assets/audio';
//   bool isInitialized = false;
//
//   final click = AudioPlayer();
//   final dumbbell = AudioPlayer();
//   final sandwich = AudioPlayer();
//   final shuffle = AudioPlayer();
//   final success = AudioPlayer();
//   final tileMove = AudioPlayer();
//   final skateboard = AudioPlayer();
//
//   Future<void> init() async {
//     if (isInitialized) return Future.value();
//
//     click.setAudioSource(AudioSource.uri(Uri.parse(
//         'https://github.com/mhanzla80/easy_puzzle_game/raw/master/audio/click.mp3')));
//     dumbbell.setAudioSource(AudioSource.uri(Uri.parse(
//         'https://github.com/mhanzla80/easy_puzzle_game/raw/master/audio/dumbbell.mp3')));
//     sandwich.setAudioSource(AudioSource.uri(Uri.parse(
//         'https://github.com/mhanzla80/easy_puzzle_game/raw/master/audio/sandwich.mp3')));
//     shuffle.setAudioSource(AudioSource.uri(Uri.parse(
//         'https://github.com/mhanzla80/easy_puzzle_game/raw/master/audio/shuffle.mp3')));
//     success.setAudioSource(AudioSource.uri(Uri.parse(
//         'https://github.com/mhanzla80/easy_puzzle_game/raw/master/audio/success.mp3')));
//     tileMove.setAudioSource(AudioSource.uri(Uri.parse(
//         'https://github.com/mhanzla80/easy_puzzle_game/raw/master/audio/tile_move.mp3')));
//     await skateboard.setAudioSource(AudioSource.uri(Uri.parse(
//         'https://github.com/mhanzla80/easy_puzzle_game/raw/master/audio/skateboard.mp3')));
//     await Future.delayed(const Duration(seconds: 2));
//     isInitialized = true;
//   }
//
//   void playClick() {
//     click.play();
//     click.load();
//   }
//
//   void playTileMove() {
//     tileMove.play();
//     tileMove.load();
//   }
//
//   void playSuccess() {
//     success.play();
//     success.load();
//   }
//
//   void playShuffle() {
//     shuffle.play();
//     shuffle.load();
//   }
//
//   void playSandwich() {
//     sandwich.play();
//     sandwich.load();
//   }
//
//   void playDumbbell() {
//     dumbbell.play();
//     dumbbell.load();
//   }
// }
