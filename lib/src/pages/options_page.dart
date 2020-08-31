import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';

class OptionsPage extends StatelessWidget {
  final prefs = UserPreferences();
  final clientRepository = ClientRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Opciones',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              prefs.accessToken = '';
              prefs.refreshToken = '';
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('initial', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: clientRepository.getCurrentClient(prefs.accessToken),
        builder: (context, AsyncSnapshot<Client> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              // return Form1(snapshot.data);
              return Form2(snapshot.data, prefs);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error));
            } else {
              return Center(child: Text('Token incorrecto'));
            }
          }
        },
      ),
    );
  }
}

class Form1 extends StatelessWidget {
  final Client client;
  const Form1(this.client);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Nombre:'),
        TextFormField(
          initialValue: client.user.firstName,
        ),
      ],
    );
  }
}

class Form2 extends StatelessWidget {
  final Client client;
  final UserPreferences preferences;
  const Form2(this.client, this.preferences);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'Nombre',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.chevron_right),
          subtitle: Text(client.user.firstName),
          onTap: () {},
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'Apellido',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Icon(Icons.face),
          trailing: Icon(Icons.chevron_right),
          subtitle: Text(client.user.lastName),
          onTap: () {},
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'Número de teléfono',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Icon(Icons.phone_android),
          trailing: Icon(Icons.chevron_right),
          subtitle: Text(client.phoneNumber),
          onTap: () {},
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'Cambiar contraseña',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Icon(Icons.lock),
          trailing: Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'Cerrar sesión',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Icon(Icons.exit_to_app),
          trailing: Icon(Icons.chevron_right),
          onTap: () async {
            preferences.accessToken = '';
            preferences.refreshToken = '';
            Navigator.of(context)
                .pushNamedAndRemoveUntil('initial', (Route<dynamic> route) => false);
            // Navigator.popUntil(context, ModalRoute.withName('initial'));
          },
        ),
      ],
    );
  }
}
