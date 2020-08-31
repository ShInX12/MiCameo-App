import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/user_model.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';

class ClientRepository {
  final prefs = UserPreferences();

  Future<Map<String, dynamic>> registerClient(String email, String password) async {
    final Map<String, String> body = {'email': email, 'password': password};
    final urlFull = Uri.https(baseUrl, 'api/auth/users/register-client');
    final response = await http.post(urlFull, body: body);

    return {'status': response.statusCode, 'body': response.body};
  }

  Future<Map<String, dynamic>> loginWithEmail(String email, String password) async {
    final Map<String, String> body = {'username': email, 'password': password};

    final urlFull = Uri.https(baseUrl, 'api/auth/users/login');
    final response = await http.post(urlFull, body: body);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      prefs.initPrefs();
      prefs.accessToken = data['access'];
      prefs.refreshToken = data['refresh'];
    }
    return {'status': response.statusCode, 'body': response.body};
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
    final Map<String, String> body = {'access_token': accessToken, 'social_network': 'facebook'};

    final urlFull = Uri.https(baseUrl, 'users/auth/social-login');
    final response = await http.post(urlFull, body: body);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      prefs.initPrefs();
      prefs.accessToken = data['access'];
      prefs.refreshToken = data['refresh'];
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginWithTwitter() async {
    final _twitterLogin = new TwitterLogin(
      consumerKey: 'uLduy0FyxqCGqnmDNUwJx4LFF',
      consumerSecret: 'ZgjpsdilbRw3j3lAxgYtlkEbVPdX5GmMgqVio6eLESacZyd8TM',
    );

    final loginResult = await _twitterLogin.authorize();

    switch (loginResult.status) {
      case TwitterLoginStatus.loggedIn:
        final session = loginResult.session;
        print('--> Sesión en Twitter iniciada con exito <--');
        bool login = await _authenticateTwitterToken(session.token, session.secret);
        return login;
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('Cancelado por el usuario');
        return false;
        break;
      case TwitterLoginStatus.error:
        print('Ha ocurrido un error');
        print(loginResult.errorMessage);
        return false;
        break;
    }
    return false;
  }

  Future _authenticateTwitterToken(String accessToken, String secretToken) async {
    final Map<String, String> body = {
      'access_token': accessToken,
      'access_token_secret': secretToken,
      'social_network': 'twitter',
      'email': 'sergio6006@hotmail.com',
    };

    final urlFull = Uri.https(baseUrl, 'users/auth/social-login');
    final response = await http.post(urlFull, body: body);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      prefs.initPrefs();
      prefs.accessToken = data['access'];
      prefs.refreshToken = data['refresh'];
      return true;
    } else {
      return false;
    }
  }

  Future<Client> getCurrentClient(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final urlFull = Uri.https(baseUrl, 'api/client/me');
    final response = await http.get(urlFull, headers: headers);

    if (response.statusCode == 200) {
      final Map reponseJson = json.decode(response.body);
      return Client.fromJson(reponseJson);
    }
    return null;
  }
}
