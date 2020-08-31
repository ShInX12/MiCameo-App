import 'package:flutter/material.dart';

const Color lightPurple = Color(0xff8B00BF);
const Color red         = Color(0xffC90046);
const Color purple      = Color(0xff5200BF);
const Color darkPurple  = Color(0xff32005F);

const Color lightGrey   = Color(0xffF2F2F2);
const Color grey        = Color(0xffCCCCCC);
const Color darkGrey    = Color(0xff666666);
const Color black       = Color(0xff262626);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  // fontFamily: 'Montserrat',
  fontFamily: 'Rubik',
  accentColor: purple,
  primaryColor: purple,
  dividerColor: grey,
  primaryColorDark: black,
  appBarTheme: AppBarTheme(
    color: Colors.white.withOpacity(0.95),
    elevation: 2,
    iconTheme: IconThemeData(color: black),
  ),
  textTheme: TextTheme(
    headline4: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
      color: black,
    ),
    headline5: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: black,
    ),
    headline6: TextStyle(
      color: black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: black,
    ),
    bodyText1: TextStyle(
      color: darkGrey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(color: darkGrey, fontSize: 14),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.transparent,
    disabledColor: grey,
    selectedColor: purple,
    secondarySelectedColor: purple,
    labelPadding: EdgeInsets.all(0),
    padding: EdgeInsets.symmetric(horizontal: 10),
    shape: StadiumBorder(side: BorderSide(color: purple, width: 1.0)),
    labelStyle: TextStyle(fontSize: 14, color: purple),
    secondaryLabelStyle: TextStyle(fontSize: 14, color: Colors.white),
    brightness: Brightness.light,
    pressElevation: 4,
  ),
);
