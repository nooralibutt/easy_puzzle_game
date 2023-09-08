import 'package:easy_puzzle_game/src/dashatar/audio_control/widget/audio_control_listener.dart';
import 'package:easy_puzzle_game/src/dashatar/bloc/dashatar_theme_bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/helpers/audio_player.dart';
import 'package:easy_puzzle_game/src/dashatar/layout/responsive_layout_builder.dart';
import 'package:easy_puzzle_game/src/dashatar/widgets/dashatar_puzzle_tile.dart';
import 'package:easy_puzzle_game/src/easy_puzzle_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template dashatar_theme_picker}
/// Displays the Dashatar theme picker to choose between
/// [MyDashatarThemeState.themes].
///
/// By default allows to choose between [MyBlueDashatarTheme],
/// [MyGreenDashatarTheme] or [MyYellowDashatarTheme].
/// {@endtemplate}
class MyDashatarThemePicker extends StatefulWidget {
  /// {@macro dashatar_theme_picker}
  const MyDashatarThemePicker({
    Key? key,
  }):
        super(key: key);

  static const _activeThemeNormalSize = 120.0;
  static const _activeThemeSmallSize = 65.0;
  static const _inactiveThemeNormalSize = 96.0;
  static const _inactiveThemeSmallSize = 50.0;


  @override
  State<MyDashatarThemePicker> createState() => _MyDashatarThemePickerState();
}

class _MyDashatarThemePickerState extends State<MyDashatarThemePicker> {



  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<MyDashatarThemeBloc>().state;
    final activeTheme = themeState.theme;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final isSmallSize = currentSize == ResponsiveLayoutSize.small;
        final activeSize = isSmallSize
            ? MyDashatarThemePicker._activeThemeSmallSize
            : MyDashatarThemePicker._activeThemeNormalSize;
        final inactiveSize = isSmallSize
            ? MyDashatarThemePicker._inactiveThemeSmallSize
            : MyDashatarThemePicker._inactiveThemeNormalSize;

        return SizedBox(
          key: const Key('dashatar_theme_picker'),
          height: activeSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              themeState.themes.length,
                  (index) {
                final theme = themeState.themes[index];
                final isActiveTheme = theme == activeTheme;
                final padding = index > 0 ? (isSmallSize ? 4.0 : 8.0) : 0.0;
                final size = isActiveTheme ? activeSize : inactiveSize;

                return Padding(
                  padding: EdgeInsets.only(left: padding),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      key: Key('dashatar_theme_picker_$index'),
                      onTap: () async {
                        if (isActiveTheme) {
                          return;
                        }

                        // Update the current Dashatar theme.
                        context
                            .read<MyDashatarThemeBloc>()
                            .add(MyDashatarThemeChanged(themeIndex: index));

                        // Play the audio of the current Dashatar theme.
                      },
                      child: AnimatedContainer(
                        width: size,
                        height: size,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 350),
                        child: ServerImage(
                          fullImage: EasyPuzzleGameController.of(context)
                              .puzzleFullImg,
                          fit: BoxFit.fill,
                          // semanticLabel: theme.semanticsLabel(context),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
