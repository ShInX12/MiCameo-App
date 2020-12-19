import 'package:flutter/material.dart';
import 'package:mi_cameo/src/repository/client_repository.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Background(type: 1),
              Text(
                'Cargando...',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> checkLoginState(BuildContext context) async {

    final clientRepository = ClientRepository();
    final isLoggedIn = await clientRepository.getCurrentClient(context);

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, 'navigation_bar');
    } else {
      Navigator.pushReplacementNamed(context, 'initial');
    }
  }
}
