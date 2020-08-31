import 'package:flutter/material.dart';
import 'package:mi_cameo/src/widgets/input_form.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class RequestCameoAsPresent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: _RequestForm(),
          ),
        ),
      ),
    );
  }
}

// Define un widget de formulario personalizado
class _RequestForm extends StatefulWidget {
  @override
  __RequestFormState createState() => __RequestFormState();
}

class __RequestFormState extends State<_RequestForm> {
  final _formKey = GlobalKey<FormState>();

  final requestModel = new _RequestModel();

  void _continue() {
    if (_formKey.currentState.validate()) {
      print('Correcto');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          _Label('De:'),
          InputRequestForm(
            textInputAction: TextInputAction.next,
            labelText: null,
            validator: (String value) {
              if (value.length == 0) return '¿Quién envía el video?';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.requestModel.to = value,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 30),
          _Label('Para:'),
          InputRequestForm(
            labelText: null,
            validator: (String value) {
              if (value.length == 0) return '¿Para quién es el video?';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.requestModel.from = value,
            onFieldSubmitted: null,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _Label('Ocasión:'),
              SizedBox(width: 30),
              Expanded(child: _Ocassions()),
            ],
          ),
          SizedBox(height: 30),
          _Label('Instrucciones:'),
          SizedBox(height: 10),
          _Instructions(
            onSaved: (String value) => this.requestModel.from = value,
            validator: (String value) {
              if (value.length == 0) return '¿cómo te gustaría que fuera el video?';
              _formKey.currentState.save();
              return null;
            },
          ),
          SizedBox(height: 30),
          ButtonType1(
            text: 'Continuar',
            colorPurple: true,
            onPressed: () => _continue(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _Ocassions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: <DropdownMenuItem<dynamic>>[
        DropdownMenuItem(child: Text('Opción')),
        DropdownMenuItem(child: Text('Opción')),
        DropdownMenuItem(child: Text('Opción')),
        DropdownMenuItem(child: Text('Opción')),
        DropdownMenuItem(child: Text('Opción')),
      ],
      onChanged: (value) {},
    );
  }
}

class _Instructions extends StatelessWidget {
  final Function onSaved;
  final Function validator;

  const _Instructions({@required this.onSaved, this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 6,
      onSaved: onSaved,
      validator: validator,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String label;

  const _Label(this.label);
  @override
  Widget build(BuildContext context) {
    return Text(label, style: Theme.of(context).textTheme.headline6);
  }
}

class _RequestModel {
  String to;
  String from;
  String ocassion;
  String intructions;
}
