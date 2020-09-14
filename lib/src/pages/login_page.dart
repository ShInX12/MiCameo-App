import 'package:flutter/material.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/widgets/input_form.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(type: 1),
          Positioned(top: 16, left: 20, child: _Logo()),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Image(image: AssetImage('assets/img/logo-light.png'), width: 100),
    );
  }
}

// Define un widget de formulario personalizado
class _LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

// Define una clase de estado correspondiente. Esta clase contendrá los datos
// relacionados con el formulario.
class __LoginFormState extends State<_LoginForm> {
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  final _formKey = GlobalKey<FormState>();
  _LoginModel loginModel = new _LoginModel();
  final _emailValidator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final clientRepository = new ClientRepository();

  void _login() async {
    if (_formKey.currentState.validate()) {

      final loginResult = await clientRepository.loginWithEmail(
        this.loginModel.email,
        this.loginModel.password,
      );

      if (loginResult['status'] == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            'navigation_bar', (Route<dynamic> route) => false);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              context: context,
              title: 'Ha ocurrido un error (${loginResult['status']})',
              content: loginResult['body'],
              onPressed: () => Navigator.pop(context),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 140),
          _Title(),
          SizedBox(height: 70),
          InputRegisterForm(
            labelText: 'Correo electrónico',
            textInputType: TextInputType.emailAddress,
            prefixIcon: Icon(Icons.email),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (String value) {
              if (value.trim().length == 0) return 'Ingresa tu correo electrónico';
              if (!_emailValidator.hasMatch(value.trim())) return 'Ingresa un correo válido';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.loginModel.email = value.trim(),
          ),
          SizedBox(height: 40),
          InputRegisterForm(
            labelText: 'Contraseña',
            obscureText: true,
            prefixIcon: Icon(Icons.lock),
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (_) => _login(),
            validator: (String value) {
              if (value.trim().length == 0) return 'Ingresa tu contraseña';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.loginModel.password = value.trim(),
          ),
          SizedBox(height: 70),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: ButtonType1(
              text: 'Ingresar',
              onPressed: () => _login(),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: FlatButtonType1(
              text: 'Olvidé mi contraseña',
              onPressed: () {},
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bienvenido de vuelta',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _LoginModel {
  String email;
  String password;

  _LoginModel({this.email, this.password});
}
