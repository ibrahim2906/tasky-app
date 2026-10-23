import 'package:flutter/material.dart';
import 'package:tasks/core/services/preference_manager.dart';
import 'package:tasks/core/theme/dark_theme.dart';
import 'package:tasks/core/theme/light_theme.dart';
import 'package:tasks/core/theme/theme_controller.dart';
import 'package:tasks/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/screens/main_screen.dart';

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
  ThemeController().init();
  final pref = await SharedPreferences.getInstance();
  String? name = pref.getString("username");
  runApp(Tasky(username: name));
}

class Tasky extends StatelessWidget {
  const Tasky({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          home: username == null ? Welcome() : const MainScreen(),
        );
      },
    );
  }
}
