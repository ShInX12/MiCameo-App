import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/order_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/repository/orders_repository.dart';
import 'package:mi_cameo/src/widgets/input_form.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class RequestCameoAsPresent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String talentName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: _RequestForm(talentName),
          ),
        ),
      ),
    );
  }
}

// Define un widget de formulario personalizado
class _RequestForm extends StatefulWidget {
  final String talentName;

  const _RequestForm(this.talentName);
  @override
  __RequestFormState createState() => __RequestFormState();
}

class __RequestFormState extends State<_RequestForm> {
  final _formKey = GlobalKey<FormState>();

  final order = new BasicOrder();
  final clientRepository = ClientRepository();
  final ordersRepository = OrdersRepository();
  final prefs = UserPreferences();
  Client client;
  bool isPublic = false;

  final occasions = <String>[
    'Cumpleaños',
    'Navidad',
    'Aniversario',
    'Casual',
    'Agradecimientos',
    'Ninguno',
    'Otro'
  ];

  @override
  void initState() {
    super.initState();
    clientRepository.getCurrentClient(prefs.accessToken).then((value) {
      client = value;
      setState(() {});
    });
  }

  void _continue() async {
    if (_formKey.currentState.validate()) {
      if (client != null) {
        order.talent = widget.talentName;
        order.emailClient = client.user.email;
        order.phoneNumber = client.phoneNumber;
        order.orderState = '1';
        order.isPublic = isPublic ? 'True' : 'False';
        print(order);
        Map result = await ordersRepository.createOrder(order);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              context: context,
              title: result['status'] == 201
                  ? 'Orden creada correctamente'
                  : 'Ha ocurrido un error (${result['status']})',
              content: result['status'] == 201
                  ? 'En unos momentos obtendras la respuesta del talento'
                  : result['body'],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          _Label('De:'),
          InputRequestForm(
            textInputAction: TextInputAction.next,
            labelText: null,
            textInputType: TextInputType.name,
            validator: (String value) {
              if (value.length == 0) return '¿Quién envía el video?';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.order.fromClient = value,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 25),
          _Label('Para:'),
          InputRequestForm(
            labelText: null,
            textInputType: TextInputType.name,
            validator: (String value) {
              if (value.length == 0) return '¿Para quién es el video?';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.order.to = value,
            onFieldSubmitted: null,
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _Label('Ocasión:'),
              SizedBox(width: 30),
              Expanded(
                child: DropdownButtonFormField(
                  value: 'Cumpleaños',
                  items: occasions.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (value) {
                    this.order.occasion = value;
                  },
                  onSaved: (value) {
                    this.order.occasion = value;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Label('Publicar video:'),
              Switch(
                value: isPublic,
                onChanged: (bool value) {
                  setState(() {
                    isPublic = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 25),
          _Label('Instrucciones:'),
          SizedBox(height: 10),
          _Instructions(
            onSaved: (String value) => this.order.instructions = value,
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
