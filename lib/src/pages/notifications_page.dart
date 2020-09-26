import 'package:flutter/material.dart';
import 'package:mi_cameo/src/bloc/orders_by_client_bloc.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/order_model.dart';
import 'package:mi_cameo/src/widgets/notification_tile.dart';
import 'package:mi_cameo/src/widgets/widgets.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    _ordersBloc = new OrdersBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notificaciones',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => _ordersBloc.fetchOrderList(),
        child: StreamBuilder(
          stream: _ordersBloc.orderListStream,
          builder: (context, AsyncSnapshot<ApiResponse<List<Order>>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                  break;
                case Status.COMPLETED:
                  if (snapshot.data.data.length == 0) {
                    return Center(child: Text('Todavía no hay notificaciones'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return NotificationTile(
                          title: snapshot.data.data[i].talent,
                          subtitle: 'Estado del cameo: ${snapshot.data.data[i].talentResponse}',
                          urlImage: 'https://picsum.photos/400/400',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                  context: context,
                                  onPressed: () => Navigator.pop(context),
                                  title: 'Detalles',
                                  content:
                                      'Talento: ${snapshot.data.data[i].talent}\nDe: ${snapshot.data.data[i].fromClient}\nPara: ${snapshot.data.data[i].to}\nOcasion: ${snapshot.data.data[i].occasion}\nInstrucciones: ${snapshot.data.data[i].instructions}\nCreado: ${snapshot.data.data[i].created}',
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                  break;
                case Status.ERROR:
                  return Center(
                    child: ErrorMessage(
                      errorMessage: snapshot.data.message,
                      onPressed: () => _ordersBloc.fetchOrderList(),
                    ),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
