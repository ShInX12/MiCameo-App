import 'package:flutter/material.dart';

class InputRegisterForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final Icon prefixIcon;
  final bool obscureText;
  final Function validator;
  final Function onSaved;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;
  // final FocusNode focusNode;

  const InputRegisterForm({
    @required this.labelText,
    this.textInputType = TextInputType.text,
    this.prefixIcon = const Icon(Icons.edit),
    this.hintText = '',
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    @required this.validator,
    @required this.onSaved,
    @required this.onFieldSubmitted,
    // @required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      // height: 50,
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: textInputType,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 18),
        validator: validator,
        onSaved: onSaved,
        textInputAction: textInputAction,
        // focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontSize: 19),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          errorStyle: TextStyle(color: Colors.red[100], fontSize: 14),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red[100]),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red[100]),
          ),
          // prefixIcon: prefixIcon,
          // hintText: 'Correo electrónico',
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ),
    );
  }
}

class InputRequestForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String initialValue;
  final TextInputType textInputType;
  final Icon prefixIcon;
  final bool obscureText;
  final Function validator;
  final Function onSaved;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;

  const InputRequestForm({
    @required this.labelText,
    this.textInputType = TextInputType.text,
    this.prefixIcon = const Icon(Icons.edit),
    this.hintText = '',
    this.initialValue = '',
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    @required this.validator,
    @required this.onSaved,
    @required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: textInputType,
        initialValue: initialValue,
        style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w400),
        validator: validator,
        onSaved: onSaved,
        textInputAction: textInputAction,
        // focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        // decoration: InputDecoration(
        //   labelText: labelText,
        //   labelStyle: TextStyle(color: Colors.white, fontSize: 19),
        //   focusedBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.white),
        //   ),
        //   enabledBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.white24),
        //   ),
        //   errorStyle: TextStyle(color: Colors.red[100], fontSize: 14),
        //   errorBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.red[100]),
        //   ),
        //   focusedErrorBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.red[100]),
        //   ),
        //   // prefixIcon: prefixIcon,
        //   // hintText: 'Correo electrónico',
        //   // border: OutlineInputBorder(
        //   //     borderRadius: BorderRadius.all(Radius.circular(30))),
        // ),
      ),
    );
  }
}
