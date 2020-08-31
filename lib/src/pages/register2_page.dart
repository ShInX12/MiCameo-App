import 'package:flutter/material.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/widgets/input_form.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class Register2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(type: 2),
          Positioned(top: 60, right: -100, child: StepBox(text: 'Paso 2')),
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
      'Ya casi hemos terminado...',
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white),
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
  _Register2Model register2model = new _Register2Model();

  final clientRepository = new ClientRepository();

  void _updateUser() {
    if (_formKey.currentState.validate())
      Navigator.of(context).pushNamedAndRemoveUntil(
          'navigation_bar', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 230),
          _Title(),
          SizedBox(height: 20),
          // Expanded(child: Center(child: _Image(width: size.width * 0.75))),
          SizedBox(height: 20),
          InputRegisterForm(
            labelText: 'Nombre',
            prefixIcon: Icon(Icons.person),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (String value) {
              if (value.length == 0) return 'Ingresa tu nombre';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.register2model.nombre = value.trim(),
          ),
          SizedBox(height: 40),
          InputRegisterForm(
            labelText: 'Indefinido',
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (_) => _updateUser(),
            prefixIcon: Icon(Icons.music_note),
            validator: (String value) {
              if (value.length == 0) return 'Ingresa el indefinido';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.register2model.indefinido = value.trim(),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: ButtonType1(
              text: 'Finalizar',
              onPressed: () => _updateUser(),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _Register2Model {
  String nombre;
  String indefinido;

  _Register2Model({this.nombre, this.indefinido});
}
