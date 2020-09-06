import 'package:flutter/material.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/widgets/input_form.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class Register1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(type: 2),
          Positioned(top: 60, right: -100, child: StepBox(text: 'Paso 1')),
          Positioned(top: 16, left: 20, child: _Logo()),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _RegisterForm(),
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
    return Text(
      'Te damos la bienvenida',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
        color: Colors.white,
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
class _RegisterForm extends StatefulWidget {
  @override
  __RegisterFormState createState() => __RegisterFormState();
}

// Define una clase de estado correspondiente. Esta clase contendrá los datos
// relacionados con el formulario.
class __RegisterFormState extends State<_RegisterForm> {
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  final _formKey = GlobalKey<FormState>();
  _Register1Model register1model = new _Register1Model();

  final clientRepository = new ClientRepository();

  void _createUser() async {
    if (_formKey.currentState.validate()) {
      final result = await clientRepository.registerClient(
        this.register1model.email,
        this.register1model.password,
      );

      if (result['status'] == 201) {}
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            context: context,
            title: result['status'] == 201
                ? 'Usuario creado'
                : 'Ha ocurrido un error (${result['status']})',
            content: result['status'] == 201
                ? 'Revisa el link enviado a tu correo para activar tu cuenta y poder iniciar sesión'
                : result['body'],
            onPressed: () => result['status'] == 201
                // ? Navigator.popAndPushNamed(context, 'register2')
                ? Navigator.pop(context)
                : Navigator.pop(context),
          );
        },
      );
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
          SizedBox(height: 230),
          _Title(),
          SizedBox(height: 40),
          InputRegisterForm(
            labelText: 'Correo electrónico',
            prefixIcon: Icon(Icons.alternate_email),
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (String value) {
              if (value.trim().length == 0)
                return 'Ingresa tu correo electrónico';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.register1model.email = value.trim(),
          ),
          SizedBox(height: 40),
          InputRegisterForm(
            textInputAction: TextInputAction.go,
            labelText: 'Contraseña',
            prefixIcon: Icon(Icons.lock),
            obscureText: true,
            onFieldSubmitted: (_) => _createUser(),
            validator: (String value) {
              if (value.trim().length == 0) return 'Ingresa tu contraseña';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) =>
                this.register1model.password = value.trim(),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: ButtonType1(
              text: 'Continuar',
              onPressed: () => _createUser(),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _Register1Model {
  String email = '';
  String password = '';

  _Register1Model({this.email, this.password});
}
