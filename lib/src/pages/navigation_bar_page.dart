import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mi_cameo/src/pages/home_page.dart';
import 'package:mi_cameo/src/pages/messages_page.dart';
import 'package:mi_cameo/src/pages/notifications_page.dart';
import 'package:mi_cameo/src/pages/profile_page.dart';
import 'package:mi_cameo/src/pages/search_page.dart';

class NavigationBarPage extends StatelessWidget {
  final _pageOptions = [
    HomePage(),
    MessagesPage(),
    SearchPage(),
    NotificationsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationState(),
      child: Builder(
        builder: (BuildContext context) {
          final navigationState = Provider.of<_NavigationState>(context);
          return Scaffold(
            body: _pageOptions[navigationState.currentPage],
            bottomNavigationBar: _Navigation(),
          );
        },
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationState = Provider.of<_NavigationState>(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationState.currentPage,
      onTap: (i) => navigationState.currentPage = i,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            // FontAwesomeIcons.home,
            Icons.home,
            color: navigationState.currentPage == 0
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColorDark,
          ),
          title: Text('Inicio'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            // FontAwesomeIcons.comment,
            Icons.message,
            color: navigationState.currentPage == 1
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColorDark,
          ),
          title: Text('Mensajes'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            // FontAwesomeIcons.search,
            Icons.search,
            color: navigationState.currentPage == 2
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColorDark,
          ),
          title: Text('Buscar'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            // FontAwesomeIcons.bell,
            Icons.notifications,
            color: navigationState.currentPage == 3
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColorDark,
          ),
          title: Text('Notificaciones'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            // FontAwesomeIcons.user,
            Icons.person,
            color: navigationState.currentPage == 4
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColorDark,
          ),
          title: Text('Perfil'),
        ),
      ],
    );
  }
}

class _NavigationState with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => this._currentPage;

  set currentPage(int page) {
    this._currentPage = page;
    notifyListeners();
  }
}
