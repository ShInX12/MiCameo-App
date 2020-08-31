import 'package:flutter/material.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';
import 'package:mi_cameo/src/routes/routes.dart';
import 'package:mi_cameo/src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Cameo',
      initialRoute: prefs.accessToken == '' ? 'initial' : 'navigation_bar',
      routes: applicationRoutes(),
      theme: lightTheme,
    );
  }
}
