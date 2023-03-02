// ignore_for_file: public_member_api_docs

part of 'dashatar_theme_bloc.dart';

abstract class MyDashatarThemeEvent extends Equatable {
  const MyDashatarThemeEvent();
}

class MyDashatarThemeChanged extends MyDashatarThemeEvent {
  const MyDashatarThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [MyDashatarThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
