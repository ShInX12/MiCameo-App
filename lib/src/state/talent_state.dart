import 'package:flutter/material.dart';
import 'package:mi_cameo/src/models/user_model.dart';

class TalentState with ChangeNotifier {
  String _userName;
  String _firstName;
  String _lastName;
  bool _favorite = false;
  int _reviews;
  int _responseDays = 1;
  String _price;
  double _stars;
  String _description;
  String _urlImage;
  List<String> _categories;

  TalentState(Talent talent) {
    this._userName = talent.user.username;
    this._firstName = talent.user.firstName;
    this._lastName = talent.user.lastName;
    this._description = talent.description;
    this._reviews = 23;
    this._responseDays = talent.responseDays;
    this._price = talent.price;
    this._stars = 4.8;
    this._favorite = true;
    this._urlImage = talent.profileImage;
    this._categories = talent.categories;
  }

  String get userName => this._userName;

  set userName(String userName) {
    this._userName = userName;
    // notifyListeners();
  }

  String get firstName => this._firstName;

  set firstName(String firstName) {
    this._firstName = firstName;
    // notifyListeners();
  }

  String get lastName => this._lastName;

  set lastName(String lastName) {
    this._lastName = lastName;
    // notifyListeners();
  }

  String get fullName => this._firstName + ' ' + this._lastName;

  bool get favorite => this._favorite;

  set favorite(bool favorite) {
    this._favorite = favorite;
    notifyListeners();
  }

  int get reviews => this._reviews;

  set reviews(int reviews) {
    this._reviews = reviews;
    // notifyListeners();
  }

  int get responseDays => this._responseDays;

  set responseDays(int responseDays) {
    this._responseDays = responseDays;
    // notifyListeners();
  }

  String get price => this._price;

  set price(String price) {
    this._price = price;
    // notifyListeners();
  }

  double get stars => this._stars;

  set stars(double stars) {
    this._stars = stars;
    // notifyListeners();
  }

  String get description => this._description;

  set description(String description) {
    this._description = description;
    // notifyListeners();
  }

  String get urlImage => this._urlImage;

  set urlImage(String urlImage) {
    this._urlImage = urlImage;
    // notifyListeners();
  }

  List<String> get categories => this._categories;

  set categories(List<String> categories) {
    this._categories = categories;
    // notifyListeners();
  }
}
