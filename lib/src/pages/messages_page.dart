import 'package:flutter/material.dart';
import 'package:mi_cameo/src/widgets/message_tile.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mensajes',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            MessageTile(
              title: 'Igor Acuña',
              subtitle: '¡Hola! Por supuesto que sí.',
              urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              messagesCount: 1,
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              height: 0,
              indent: 12,
              endIndent: 12,
            ),
            MessageTile(
              title: 'Brais Guzman',
              subtitle: 'Gracias!, estoy atento. fsdf ff fdfs fds fds sfdf sd',
              urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
              messagesCount: 3,
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              height: 0,
              indent: 12,
              endIndent: 12,
            ),
            MessageTile(
              title: 'Sergio Hervas',
              subtitle:
                  '¡Hola! Por supuesto que sí. gfdg gfdg gfdg gfg gdfgd fdg',
              urlImage: 'https://pbs.twimg.com/media/EZzYzLvWsAAk6jR.jpg',
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              height: 0,
              indent: 12,
              endIndent: 12,
            ),
          ],
        ),
      ),
    );
  }
}
