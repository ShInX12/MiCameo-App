import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/pages/initial_page.dart';
import 'package:mi_cameo/src/pages/navigation_bar_page.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
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
    final _clientRepository = new ClientRepository();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Cameo',
      routes: applicationRoutes(),
      theme: lightTheme,
      home: FutureBuilder(
        future: _clientRepository.getCurrentClient(prefs.accessToken),
        builder: (context, AsyncSnapshot<Client> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Scaffold();
              break;
            default:
              if (snapshot.hasError)
                return Scaffold(body: Center(child: Text('Error')));
              else if (snapshot.data == null)
                return InitialPage();
              else
                return NavigationBarPage();
          }
        },
      ),
    );
  }
}
