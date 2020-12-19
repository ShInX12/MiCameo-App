import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/user_model.dart';

class ClientState with ChangeNotifier {

  Client _client;

  Client get client => this._client;

  set client(Client client) {
    this._client = client;
    notifyListeners();
  }
  
}