import 'package:bloc/bloc.dart';
import 'package:easy_puzzle_game/src/dashatar/dashatar.dart';
import 'package:equatable/equatable.dart';

part 'dashatar_theme_event.dart';
part 'dashatar_theme_state.dart';

/// {@template dashatar_theme_bloc}
/// Bloc responsible for the currently selected [MyDashatarTheme].
/// {@endtemplate}
class MyDashatarThemeBloc
    extends Bloc<MyDashatarThemeEvent, MyDashatarThemeState> {
  /// {@macro dashatar_theme_bloc}
  MyDashatarThemeBloc({required List<MyDashatarTheme> themes})
      : super(MyDashatarThemeState(themes: themes)) {
    on<MyDashatarThemeChanged>(_onDashatarThemeChanged);
  }

  void _onDashatarThemeChanged(
    MyDashatarThemeChanged event,
    Emitter<MyDashatarThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
