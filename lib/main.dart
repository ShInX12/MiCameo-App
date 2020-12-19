import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';
import 'package:mi_cameo/src/routes/routes.dart';
import 'package:mi_cameo/src/state/client_state.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ClientState())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mi Cameo',
        routes: applicationRoutes(),
        theme: lightTheme,
        initialRoute: 'loading',
      ),
    );
  }
}
