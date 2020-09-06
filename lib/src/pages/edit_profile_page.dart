import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil', style: TextStyle(color: Colors.black87)),
      ),
      body: SafeArea(child: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();
    final clientRepository = ClientRepository();
    return FutureBuilder(
      future: clientRepository.getCurrentClient(prefs.accessToken),
      builder: (context, AsyncSnapshot<Client> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return _ProfileForm(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          } else {
            return Center(child: Text('No se pudo obtener el usuario'));
          }
        }
      },
    );
  }
}

class _ProfileForm extends StatefulWidget {
  final Client client;

  const _ProfileForm(this.client);

  @override
  __ProfileFormState createState() => __ProfileFormState();
}

class __ProfileFormState extends State<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final clientRepository = ClientRepository();
  final _dateValidation = RegExp(r'^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$');

  void _save() async {
    if (_formKey.currentState.validate()) {
      if (widget.client.birthday == '') widget.client.birthday = null;
      User userResponse = await clientRepository.updateUser(widget.client.user);
      Client clientResponse = await clientRepository.updateClient(widget.client);

      if (clientResponse != null && userResponse != null) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              context: context,
              title: 'Perfil actualizado',
              content: 'El perfil ha sido actualizado correctamente',
              buttonText: 'Continuar',
              onPressed: () => Navigator.pop(context),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              context: context,
              title: 'Error',
              content: 'Ha ocurrido un error al actualizar el perfil',
              buttonText: 'Continuar',
              onPressed: () => Navigator.pop(context),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22),
        children: <Widget>[
          SizedBox(height: 40),
          Text('Nombre'),
          TextFormField(
            initialValue: widget.client.user.firstName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (String value) {
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => widget.client.user.firstName = value.trim(),
          ),
          SizedBox(height: 20),
          Text('Apellido'),
          TextFormField(
            initialValue: widget.client.user.lastName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (String value) {
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => widget.client.user.lastName = value.trim(),
          ),
          SizedBox(height: 20),
          Text('Número de teléfono'),
          TextFormField(
            initialValue: widget.client.phoneNumber,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (String value) {
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => widget.client.phoneNumber = value.trim(),
          ),
          SizedBox(height: 20),
          Text('Fecha de nacimiento (yyyy-mm-dd)'),
          TextFormField(
            initialValue: widget.client.birthday,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: (String value) {
              if (value.length == 0) {
                _formKey.currentState.save();
                return null;
              }
              if (!_dateValidation.hasMatch(value.trim())) return 'Formato incorrecto';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => widget.client.birthday = value.trim(),
          ),
          SizedBox(height: 60),
          ButtonType1(
            text: 'Guardar',
            colorPurple: true,
            onPressed: () => _save(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
