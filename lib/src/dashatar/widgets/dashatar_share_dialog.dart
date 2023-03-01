import 'dart:async';

import 'package:easy_puzzle_game/src/dashatar/audio_control/widget/audio_control_listener.dart';
import 'package:easy_puzzle_game/src/dashatar/colors/colors.dart';
import 'package:easy_puzzle_game/src/dashatar/helpers/audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_gap.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/my_audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_score.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_share_dialog_animated_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_share_your_score.dart';
import 'package:flutter/material.dart';

/// {@template dashatar_share_dialog}
/// Displays a Dashatar share dialog with a score of the completed puzzle
/// and an option to share the score using Twitter or Facebook.
/// {@endtemplate}
class MyDashatarShareDialog extends StatefulWidget {
  /// {@macro dashatar_share_dialog}
  const MyDashatarShareDialog({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  }) : super(key: key);

  @override
  State<MyDashatarShareDialog> createState() => _MyDashatarShareDialogState();
}

class _MyDashatarShareDialogState extends State<MyDashatarShareDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    MyAudioPlayer.instance.playSuccess();
    MyAudioPlayer.instance.playClick();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    Future.delayed(
      const Duration(milliseconds: 140),
      _controller.forward,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AudioControlListener(
      key: const Key('dashatar_share_dialog_success_audio_player'),
      child: AudioControlListener(
        key: const Key('dashatar_share_dialog_click_audio_player'),
        child: ResponsiveLayoutBuilder(
          small: (_, child) => child!,
          medium: (_, child) => child!,
          large: (_, child) => child!,
          child: (currentSize) {
            final padding = currentSize == ResponsiveLayoutSize.large
                ? const EdgeInsets.fromLTRB(68, 82, 68, 73)
                : (currentSize == ResponsiveLayoutSize.medium
                    ? const EdgeInsets.fromLTRB(48, 54, 48, 53)
                    : const EdgeInsets.fromLTRB(20, 99, 20, 76));

            final closeIconOffset = currentSize == ResponsiveLayoutSize.large
                ? const Offset(44, 37)
                : (currentSize == ResponsiveLayoutSize.medium
                    ? const Offset(25, 28)
                    : const Offset(17, 63));

            final crossAxisAlignment = currentSize == ResponsiveLayoutSize.large
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center;

            return Stack(
              key: const Key('dashatar_share_dialog'),
              children: [
                SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        child: Padding(
                          padding: padding,
                          child: MyDashatarShareDialogAnimatedBuilder(
                            animation: _controller,
                            builder: (context, child, animation) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: crossAxisAlignment,
                                children: [
                                  SlideTransition(
                                    position: animation.scoreOffset,
                                    child: Opacity(
                                      opacity: animation.scoreOpacity.value,
                                      child: const MyDashatarScore(),
                                    ),
                                  ),
                                  const ResponsiveGap(
                                    small: 40,
                                    medium: 40,
                                    large: 80,
                                  ),
                                  MyDashatarShareYourScore(
                                    animation: animation,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: closeIconOffset.dx,
                  top: closeIconOffset.dy,
                  child: IconButton(
                    key: const Key('dashatar_share_dialog_close_button'),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 18,
                    icon: const Icon(
                      Icons.close,
                      color: PuzzleColors.black,
                    ),
                    onPressed: () {
                      MyAudioPlayer.instance.playClick();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
