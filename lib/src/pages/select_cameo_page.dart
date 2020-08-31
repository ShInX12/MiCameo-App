import 'package:flutter/material.dart';
import 'package:mi_cameo/src/themes/theme.dart';

class SelectCameoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            _Title(),
            SizedBox(height: 100),
            _Button(
              icon: Icon(Icons.card_giftcard),
              label: 'Para alguien mas',
              onPressed: () => Navigator.pushNamed(context, 'request_present'),
            ),
            SizedBox(height: 60),
            _Button(
              icon: Icon(Icons.person),
              label: 'Para mi',
              onPressed: () => Navigator.pushNamed(context, 'request'),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'El video es...',
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onPressed;

  const _Button({
    @required this.onPressed,
    this.label = '',
    this.icon = const Icon(Icons.cake),
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black38, blurRadius: 12, spreadRadius: -2),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: <Widget>[
                icon,
                SizedBox(width: 12),
                Text(
                  label,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
