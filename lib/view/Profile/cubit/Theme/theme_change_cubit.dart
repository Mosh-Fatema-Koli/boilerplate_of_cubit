
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository repository;

  ThemeCubit(this.repository) : super(const ThemeState(themeMode: ThemeMode.light)) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final mode = await repository.loadThemeMode();
    emit(ThemeState(themeMode: mode));
  }

  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newMode));
    repository.saveThemeMode(newMode);
  }


}
