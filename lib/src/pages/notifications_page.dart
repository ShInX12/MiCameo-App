import 'package:flutter/material.dart';
import 'package:mi_cameo/src/widgets/notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notificaciones',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            NotificationTile(
              title: 'Sergio Hervas',
              subtitle: 'Ha realizado tu cameo',
              urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              accentColor: true,
              onTap: () {},
            ),
            NotificationTile(
              title: 'Paula Aroca',
              subtitle: 'No aceptó realizar tu cameo',
              urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              accentColor: false,
              onTap: () {},
            ),
            NotificationTile(
              title: 'Michael Jackson',
              subtitle: 'Aceptó realizar tu cameo',
              urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              accentColor: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
