import 'package:easy_puzzle_game/src/dashatar/audio_control/widget/audio_control_listener.dart';
import 'package:easy_puzzle_game/src/dashatar/helpers/links_helper.dart';
import 'package:easy_puzzle_game/src/dashatar/my_audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The url to share for this Flutter Puzzle challenge.
const _shareUrl = 'https://flutterhack.devpost.com/';

/// {@template dashatar_twitter_button}
/// Displays a button that shares the Flutter Puzzle challenge
/// on Twitter when tapped.
/// {@endtemplate}
class MyDashatarTwitterButton extends StatelessWidget {
  /// {@macro dashatar_twitter_button}
  const MyDashatarTwitterButton({Key? key}) : super(key: key);

  String _twitterShareUrl(BuildContext context) {
    // final shareText = context.l10n.dashatarSuccessShareText;
    final encodedShareText = Uri.encodeComponent('');
    return 'https://twitter.com/intent/tweet?url=$_shareUrl&text=$encodedShareText';
  }

  @override
  Widget build(BuildContext context) {
    return MyDashatarShareButton(
      title: 'Twitter',
      icon: Image.asset(
        'assets/images/twitter_icon.png',
        width: 13.13,
        height: 10.67,
      ),
      color: const Color(0xFF13B9FD),
      onPressed: () => openLink(_twitterShareUrl(context)),
    );
  }
}

/// {@template dashatar_facebook_button}
/// Displays a button that shares the Flutter Puzzle challenge
/// on Facebook when tapped.
/// {@endtemplate}
class DashatarFacebookButton extends StatelessWidget {
  /// {@macro dashatar_facebook_button}
  const DashatarFacebookButton({Key? key}) : super(key: key);

  String _facebookShareUrl(BuildContext context) {
    // final shareText = context.l10n.dashatarSuccessShareText;
    final encodedShareText = Uri.encodeComponent('');
    return 'https://www.facebook.com/sharer.php?u=$_shareUrl&quote=$encodedShareText';
  }

  @override
  Widget build(BuildContext context) {
    return MyDashatarShareButton(
      title: 'Facebook',
      icon: Image.asset(
        'assets/images/facebook_icon.png',
        width: 6.56,
        height: 13.13,
      ),
      color: const Color(0xFF0468D7),
      onPressed: () => openLink(_facebookShareUrl(context)),
    );
  }
}

/// {@template dashatar_share_button}
/// Displays a share button colored with [color] which
/// displays the [icon] and [title] as its content.
/// {@endtemplate}
@visibleForTesting
class MyDashatarShareButton extends StatefulWidget {
  /// {@macro dashatar_share_button}
  const MyDashatarShareButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// The title of this button.
  final String title;

  /// The icon of this button.
  final Widget icon;

  /// The color of this button.
  final Color color;

  @override
  State<MyDashatarShareButton> createState() => _MyDashatarShareButtonState();
}

class _MyDashatarShareButtonState extends State<MyDashatarShareButton> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AudioControlListener(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(color: widget.color),
          borderRadius: BorderRadius.circular(32),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: widget.color,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            backgroundColor: Colors.transparent,
          ),
          onPressed: () async {
            widget.onPressed();
            MyAudioPlayer.instance.playClick();
          },
          child: Row(
            children: [
              const Gap(12),
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  alignment: Alignment.center,
                  width: 32,
                  height: 32,
                  color: widget.color,
                  child: widget.icon,
                ),
              ),
              const Gap(10),
              Text(
                widget.title,
                style: PuzzleTextStyle.headline5.copyWith(
                  color: widget.color,
                ),
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}
