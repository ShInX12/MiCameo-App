import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mi_cameo/src/themes/theme.dart';

class ButtonType1 extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final bool colorPurple;
  final bool shadow;

  const ButtonType1({
    @required this.text,
    @required this.onPressed,
    this.color = Colors.white,
    this.textColor = darkPurple,
    this.colorPurple = false,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: shadow ? 10.0 : 1.0,
      color: colorPurple ? purple : color,
      textColor: colorPurple ? Colors.white : textColor,
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class FlatButtonType1 extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;

  const FlatButtonType1({
    @required this.text,
    @required this.onPressed,
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String content;
  final String buttonText;
  final Function onPressed;

  const CustomAlertDialog({
    @required this.context,
    this.title = '',
    this.content = '',
    this.buttonText = 'Aceptar',
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content, style: Theme.of(context).textTheme.bodyText1),
      actions: <Widget>[
        FlatButton(
          child: Text(buttonText),
          onPressed: onPressed,
        )
      ],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final Function onPressed;
  final String errorMessage;
  final String buttonText;

  const ErrorMessage({
    this.onPressed,
    @required this.errorMessage,
    this.buttonText = 'Reintentar',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              errorMessage == null ? '' : errorMessage,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(height: 10),
          Flexible(
            child: RaisedButton(
              child: Text(buttonText),
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  final int type;

  const Background({this.type = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(painter: BackgroundDesign(type: type)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xff32005F), Color(0xff5200BF)],
        ),
      ),
    );
  }
}

class BackgroundDesign extends CustomPainter {
  final int type;

  BackgroundDesign({this.type = 1});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    paint.color = darkPurple;
    paint.strokeWidth = 8;
    paint.style = PaintingStyle.stroke;

    num degToRad(num deg) => deg * (pi / 180.0);

    final path = new Path();

    if (type == 1) {
      path.arcTo(
        // Rect.fromLTWH(-100, -100, size.width / 1.8, size.height / 3.2),
        Rect.fromLTWH(-100, -100, 360 / 1.8, 716 / 3.2),
        degToRad(-50), // Rotacion
        degToRad(190), // Longitud
        true,
      );

      path.arcTo(
        // Rect.fromLTWH(-110, -100, size.width / 1.3, size.height / 2.65),
        Rect.fromLTWH(-110, -100, 360 / 1.3, 716 / 2.65),
        degToRad(-40), // Rotacion
        degToRad(150), // Longitud
        true,
      );
    }

    // Width = 360
    // Height = 716.66666 - 760

    if (type == 2) {
      path.arcTo(
        // Rect.fromLTWH(-60, -95, size.width / 1.4, size.height / 3.2),
        Rect.fromLTWH(-60, -95, 360 / 1.4, 716 / 3.2),
        degToRad(-50), // Rotacion
        degToRad(190), // Longitud
        true,
      );

      path.arcTo(
        // Rect.fromLTWH(-40, -100, size.width / 1.13, size.height / 2.7),
        Rect.fromLTWH(-40, -100, 360 / 1.13, 716 / 2.7),
        degToRad(-50), // Rotacion
        degToRad(190), // Longitud
        true,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundDesign oldDelegate) => true;
}

class StepBox extends StatelessWidget {
  final String text;

  const StepBox({@required this.text});

  num degToRad(num deg) => deg * (pi / 180.0);
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: degToRad(-90),
      child: Container(
        alignment: Alignment.center,
        width: 260,
        height: 80,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 6,
          ),
        ),
        decoration: BoxDecoration(
          color: purple,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
        ),
      ),
    );
  }
}
