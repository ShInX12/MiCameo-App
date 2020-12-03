// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' as services;
import 'dart:convert';

// void cambiarStatusLight() {
//   services.SystemChrome.setSystemUIOverlayStyle(
//       services.SystemUiOverlayStyle.light.copyWith(
//     statusBarColor: Colors.transparent,
//     // systemNavigationBarColor: Colors.white,
//     // systemNavigationBarIconBrightness: Brightness.dark,
//   ));
// }

// void cambiarStatusDark() {
//   services.SystemChrome.setSystemUIOverlayStyle(
//       services.SystemUiOverlayStyle.dark.copyWith(
//     statusBarColor: Colors.transparent,
//     // systemNavigationBarColor: Colors.white,
//     // systemNavigationBarIconBrightness: Brightness.dark,
//   ));
// }

String errorsMapping(String str) {
  String errors = '';
  Map body = json.decode(str);
  if (body.containsKey('errors')){
    body['errors'].forEach((e) {
      if (e.containsKey('field')) errors += e['field'] + ': ';
      if (e.containsKey('message')) errors += e['message'] + '\n' + '\n';
    });
  } else {
    return 'Error no especificado';
  }

  return errors.substring(0, errors.length - 2);
}
