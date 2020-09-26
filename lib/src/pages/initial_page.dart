import 'package:flutter/material.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Background(type: 1),
          SingleChildScrollView(child: Center(child: _Body())),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  
  void _loginWithFacebook(BuildContext context) async {
    final clientRepository = new ClientRepository();
    var isLoggedIn = await clientRepository.loginWithFacebook();
    if (isLoggedIn) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          'navigation_bar', (Route<dynamic> route) => false);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            context: context,
            title: 'Ha ocurrido un error',
            content: 'Vuelve a intentarlo',
            onPressed: () => Navigator.pop(context),
          );
        },
      );
    }
  }

  // void _loginWithTwitter(BuildContext context) async {
  //   final clientRepository = new ClientRepository();
  //   var isLoggedIn = await clientRepository.loginWithTwitter();
  //   if (isLoggedIn) {
  //     Navigator.of(context).pushNamedAndRemoveUntil(
  //         'navigation_bar', (Route<dynamic> route) => false);
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CustomAlertDialog(
  //           context: context,
  //           title: 'Ha ocurrido un error',
  //           content: 'Vuelve a intentarlo',
  //           onPressed: () => Navigator.pop(context),
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            _Logo(),
            SizedBox(height: 60),
            _Title(),
            SizedBox(height: 60),
            ButtonType1(
              text: 'Iniciar Sesión',
              onPressed: () => Navigator.pushNamed(context, 'login'),
            ),
            // SizedBox(height: 20),
            // ButtonType1(
            //   color: Color(0xff1DA1F2),
            //   textColor: Colors.white,
            //   text: 'Ingresar con Twitter',
            //   onPressed: () => _loginWithTwitter(context),
            // ),
            SizedBox(height: 20),
            ButtonType1(
              color: Color(0xff006AFF),
              textColor: Colors.white,
              text: 'Ingresar con Facebook',
              onPressed: () => _loginWithFacebook(context),
            ),
            SizedBox(height: 60),
            Text(
              '¿Aún no tienes cuenta?',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            FlatButtonType1(
              text: 'Registrarse',
              onPressed: () => Navigator.pushNamed(context, 'register1'),
              color: Colors.white,
            )
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
      'Bienvenido',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(image: AssetImage('assets/img/isotipo.png'), width: 90),
        SizedBox(height: 5),
        Image(image: AssetImage('assets/img/logo-light.png'), width: 120),
      ],
    );
  }
}
