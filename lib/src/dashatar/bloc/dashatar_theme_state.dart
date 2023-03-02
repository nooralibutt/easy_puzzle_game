// ignore_for_file: public_member_api_docs

part of 'dashatar_theme_bloc.dart';

class MyDashatarThemeState extends Equatable {
  const MyDashatarThemeState({
    required this.themes,
    this.theme = const MyBlueDashatarTheme(),
  });

  /// The list of all available [MyDashatarTheme]s.
  final List<MyDashatarTheme> themes;

  /// Currently selected [MyDashatarTheme].
  final MyDashatarTheme theme;

  @override
  List<Object> get props => [themes, theme];

  MyDashatarThemeState copyWith({
    List<MyDashatarTheme>? themes,
    MyDashatarTheme? theme,
  }) {
    return MyDashatarThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
