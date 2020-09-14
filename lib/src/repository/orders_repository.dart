import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/order_model.dart';

class OrdersRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Map<String, dynamic>> createOrder(BasicOrder order) async {
    try {
      final Map<String, dynamic> body = order.toJson();
      final urlFull = Uri.https(baseUrl, 'api/orders/');
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.post(urlFull, body: json.encode(body), headers: headers);
      return {'status': response.statusCode, 'body': response.body};
    } on SocketException {
      return {'status': 600, 'body': 'No hay conexión a internet'};
    } catch (e) {
      return {'status': 600, 'body': 'Ha ocurrido un error interno: $e'};
    }
  }

  Future<List<Order>> fetchOrders(String email) async {
    final Map<String, String> params = {'email': email};
    final List response = await _helper.get(url: 'api/orders/client', params: params);
    return response.map((e) => Order.fromJson(e)).toList();
  }
}
