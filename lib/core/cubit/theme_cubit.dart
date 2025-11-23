import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/data/shared_prefernces.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final MySharedPreferences preferences;

  ThemeCubit(this.preferences) : super(ThemeMode.system) {
    loadTheme();
  }

  void loadTheme() {
    final isDark = preferences.getThemeIsDark();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    preferences.saveThemeIsDark(newMode == ThemeMode.dark);
    emit(newMode);
  }
}
