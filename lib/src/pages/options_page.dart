import 'package:flutter/material.dart';
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
      ),
      body: Form2(prefs),
    );
  }
}

class Form2 extends StatelessWidget {
  final UserPreferences preferences;
  Form2(this.preferences);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'Editar perfil',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, 'edit_profile'),
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
            'Método de pago',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Icon(Icons.credit_card),
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
            preferences.email = '';
            Navigator.of(context)
                .pushNamedAndRemoveUntil('initial', (Route<dynamic> route) => false);
            // Navigator.popUntil(context, ModalRoute.withName('initial'));
          },
        ),
      ],
    );
  }
}
