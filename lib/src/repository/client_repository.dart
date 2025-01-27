import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/helpers/helpers.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';
import 'package:mi_cameo/src/state/client_state.dart';

class ClientRepository {
  final prefs = UserPreferences();

  Future<Map<String, dynamic>> registerClient(String email, String password) async {
    try {
      final Map<String, String> body = {'email': email, 'password': password};
      final urlFull = Uri.https(baseUrl, 'api/auth/users/register-client');
      final response = await http.post(urlFull, body: body);
      return {'status': response.statusCode, 'body': response.body};
    } on SocketException {
      return {'status': 600, 'body': 'No hay conexión a internet'};
    } catch (e) {
      return {'status': 600, 'body': 'Ha ocurrido un error interno: $e'};
    }
  }

  Future<User> updateUser(User user) async {
    try {
      final Map<String, dynamic> body = user.toJson();
      final Map<String, String> headers = {
        'Authorization': 'Bearer ${prefs.accessToken}',
        'Content-Type': 'application/json'
      };
      final urlFull = Uri.https(baseUrl, 'api/users/${user.username}/');
      final response = await http.patch(urlFull, body: json.encode(body), headers: headers);
      if (response.statusCode == 200) {
        final jsonUser = json.decode(utf8.decode(response.bodyBytes));
        return User.fromJson(jsonUser);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Client> updateClient(Client client) async {
    try {
      final Map<String, dynamic> body = client.toJson();
      final Map<String, String> headers = {
        'Authorization': 'Bearer ${prefs.accessToken}',
        'Content-Type': 'application/json'
      };
      final urlFull = Uri.https(baseUrl, 'api/client/${client.user.username}/');
      final response = await http.patch(urlFull, body: json.encode(body), headers: headers);
      if (response.statusCode == 200) {
        final Map jsonClient = json.decode(utf8.decode(response.bodyBytes));
        return Client.fromJson(jsonClient);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> loginWithEmail(String email, String password) async {
    try {
      final Map<String, String> body = {'username': email, 'password': password};
      final urlFull = Uri.https(baseUrl, 'api/auth/users/login');
      final response = await http.post(urlFull, body: body);
      if (response.statusCode == 200) {
        final Map data = json.decode(utf8.decode(response.bodyBytes));
        if (data['is_talent'] == true) {
          return {'status': 401, 'body': 'Ya estas registrado como talento'};
        }
        prefs.initPrefs();
        prefs.accessToken = data['access'];
        prefs.refreshToken = data['refresh'];
      }
      return {'status': response.statusCode, 'body': errorsMapping(response.body)};
    } on SocketException {
      return {'status': 600, 'body': 'No hay conexión a internet'};
    } catch (e) {
      return {'status': 600, 'body': 'Ha ocurrido un error interno: $e'};
    }
  }

  Future<bool> loginWithFacebook() async {
    final _facebookLogin = new FacebookLogin();
    final loginResult = await _facebookLogin.logIn(['email']);
    switch (loginResult.status) {
      case FacebookLoginStatus.loggedIn:
        bool login = await _authenticateFacebookToken(loginResult.accessToken.token);
        return login;
        break;

      case FacebookLoginStatus.cancelledByUser:
        print('Cancelado por el usuario');
        return false;
        break;

      case FacebookLoginStatus.error:
        print('Ha ocurrido un error');
        print(loginResult.errorMessage);
        return false;
        break;
    }
    return false;
  }

  Future<bool> _authenticateFacebookToken(String accessToken) async {
    try {
      final Map<String, String> body = {'access_token': accessToken, 'social_network': 'facebook'};

      final urlFull = Uri.https(baseUrl, 'api/auth/users/social-login');
      final response = await http.post(urlFull, body: body);

      if (response.statusCode == 200) {
        final Map data = json.decode(response.body);
        prefs.initPrefs();
        prefs.accessToken = data['access'];
        prefs.refreshToken = data['refresh'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Future<bool> loginWithTwitter() async {
  //   final _twitterLogin = new TwitterLogin(
  //     consumerKey: '',
  //     consumerSecret: '',
  //   );

  //   final loginResult = await _twitterLogin.authorize();

  //   switch (loginResult.status) {
  //     case TwitterLoginStatus.loggedIn:
  //       final session = loginResult.session;
  //       print('--> Sesión en Twitter iniciada con exito <--');
  //       bool login = await _authenticateTwitterToken(session.token, session.secret);
  //       return login;
  //       break;
  //     case TwitterLoginStatus.cancelledByUser:
  //       print('Cancelado por el usuario');
  //       return false;
  //       break;
  //     case TwitterLoginStatus.error:
  //       print('Ha ocurrido un error');
  //       print(loginResult.errorMessage);
  //       return false;
  //       break;
  //   }
  //   return false;
  // }

  // Future _authenticateTwitterToken(String accessToken, String secretToken) async {
  //   try {
  //     final Map<String, String> body = {
  //       'access_token': accessToken,
  //       'access_token_secret': secretToken,
  //       'social_network': 'twitter',
  //       'email': 'sergio6006@hotmail.com',
  //     };

  //     final urlFull = Uri.https(baseUrl, 'users/auth/social-login');
  //     final response = await http.post(urlFull, body: body);

  //     if (response.statusCode == 200) {
  //       final Map data = json.decode(response.body);
  //       prefs.initPrefs();
  //       prefs.accessToken = data['access'];
  //       prefs.refreshToken = data['refresh'];
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<User> getCurrentUser() async {
    if (prefs.accessToken == '') return null;

    try {
      Map<String, String> headers = {'Authorization': 'Bearer ${prefs.accessToken}'};
      final urlFull = Uri.https(baseUrl, 'api/users/me');
      final response = await http.get(urlFull, headers: headers);

      if (response.statusCode == 200) {
        final Map jsonUser = json.decode(utf8.decode(response.bodyBytes));
        return User.fromJson(jsonUser);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> getCurrentClient(BuildContext context) async {
    if (prefs.accessToken == '') return false;

    try {
      Map<String, String> headers = {'Authorization': 'Bearer ${prefs.accessToken}'};

      final urlFull = Uri.https(baseUrl, 'api/client/me');
      final response = await http.get(urlFull, headers: headers);

      if (response.statusCode == 200) {
        final Map jsonClient = json.decode(utf8.decode(response.bodyBytes));
        Provider.of<ClientState>(context, listen: false).client = Client.fromJson(jsonClient);
        prefs.email = Client.fromJson(jsonClient).user.email;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
