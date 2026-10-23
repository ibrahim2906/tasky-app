import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/preference_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.system,
  );

  init() {
    bool result = PreferenceManager().getBool('theme') ?? true;
    themeNotifier.value = result ? ThemeMode.light : ThemeMode.dark;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferenceManager().setBool('theme', true);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferenceManager().setBool('theme', false);
    }
  }

  static bool isDark()=>ThemeController.themeNotifier.value==ThemeMode.dark;
}
