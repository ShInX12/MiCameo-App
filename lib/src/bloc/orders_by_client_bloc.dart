import 'dart:async';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/order_model.dart';
import 'package:mi_cameo/src/repository/orders_repository.dart';

class OrdersBloc {
  StreamController _orderListController;
  OrdersRepository _ordersRepository;

  StreamSink<ApiResponse<List<Order>>> get orderListSink => _orderListController.sink;
  Stream<ApiResponse<List<Order>>> get orderListStream => _orderListController.stream;

  OrdersBloc() {
    _orderListController = StreamController<ApiResponse<List<Order>>>();
    _ordersRepository = OrdersRepository();
    fetchOrderList();
  }

  Future<void> fetchOrderList() async {
    orderListSink.add(ApiResponse.loading('Cargando categorías'));
    try {
      List<Order> orders = await _ordersRepository.fetchOrders('sergio6006@hotmail.com');
      orderListSink.add(ApiResponse.completed(orders));
    } catch (e) {
      orderListSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _orderListController?.close();
  }
}
