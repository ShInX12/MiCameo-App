import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String baseUrl = 'app.micameo.company';

class ApiBaseHelper {

  Future<dynamic> get({String url,
                       Map<String, String> params = const {},
                       Map<String, String> headers = const {}}) async {

    var responseJson;

    try {
      final urlFull = Uri.https(baseUrl, url, params);
      final response = await http.get(urlFull, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Ha ocurrido un error durante la comunicación con el servidor: ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message]) : super(message, "Error: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Solicitud inválida: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "No autorizado: ");
}

class ApiResponse<T> {
  Status status;
  T data;
  String message;

  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  // @Override
  String toString() {
    return "Estado: $status\nMensaje: $message\nDatos: $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
