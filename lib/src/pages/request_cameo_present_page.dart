import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/ocassion_model.dart';
import 'package:mi_cameo/src/models/order_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/repository/orders_repository.dart';
import 'package:mi_cameo/src/state/client_state.dart';
import 'package:mi_cameo/src/widgets/input_form.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RequestCameoAsPresent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar Cameo', style: TextStyle(color: Colors.black87)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: _RequestForm(arguments['userName'], arguments['price']),
          ),
        ),
      ),
    );
  }
}

// Define un widget de formulario personalizado
class _RequestForm extends StatefulWidget {
  final String talentName;
  final String talentPrice;

  const _RequestForm(this.talentName, this.talentPrice);
  @override
  __RequestFormState createState() => __RequestFormState();
}

class __RequestFormState extends State<_RequestForm> {
  final _formKey = GlobalKey<FormState>();

  final order = new BasicOrder();
  final clientRepository = ClientRepository();
  final ordersRepository = OrdersRepository();
  Client client;
  bool isPublic = false;
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();

  bool _loading = false;

  var occasions = <Ocassion>[
    Ocassion(name: 'Seleccionar...'),
  ];

  @override
  void initState() {
    super.initState();
    this.client = Provider.of<ClientState>(context, listen: false).client;
    _setText();
    ordersRepository.fetchOcassions().then((value) {
      occasions.addAll(value);
      setState(() {});
    });
  }

  void _setText() {
    phoneNumberController.text = client.phoneNumber;
    nameController.text = client.user.firstName;
  }

  void _continue() async {
    if (_formKey.currentState.validate()) {
      if (client != null) {
        setState(() => this._loading = true);

        order.talent = widget.talentName;
        order.orderPrice = int.parse(widget.talentPrice.split('.')[0].trim());
        order.emailClient = client.user.email;
        order.orderState = '1';
        order.isPublic = isPublic ? 'True' : 'False';
        Map result = await ordersRepository.createOrder(order);

        FocusScope.of(context).unfocus();
        setState(() => this._loading = false);

        showCustomAlertDialog(
          context,
          result['status'] == 201
              ? 'Orden creada correctamente'
              : 'Ha ocurrido un error (${result['status']})',
          result['status'] == 201
              ? 'Mas adelante obtendrás la respuesta del talento'
              : result['body'],
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
          SizedBox(height: 20),
          _Label('De:'),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            controller: nameController,
            style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w400),
            validator: (String value) {
              if (value.length == 0) return '¿Quién envía el video?';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.order.fromClient = value,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 25),
          _Label('Telefóno:'),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            controller: phoneNumberController,
            style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w400),
            validator: (String value) {
              if (value.length == 0) return '¿Dónde te podemos notificar?';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => this.order.phoneNumber = value,
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
                  value: 'Seleccionar...',
                  items: occasions
                      .map((e) => DropdownMenuItem(child: Text(e.name), value: e.name))
                      .toList(),
                  validator: (value) {
                    if (value == 'Seleccionar...') return 'Selecciona una ocasión';
                    _formKey.currentState.save();
                    return null;
                  },
                  onChanged: (value) => this.order.occasion = value,
                  onSaved: (value) => this.order.occasion = value,
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
                  setState(() => isPublic = value);
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
            text: _loading ? 'Enviando...' : 'Enviar solicitud',
            colorPurple: true,
            onPressed: _loading ? () {} : _continue,
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
      maxLines: 5,
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
